`timescale 1ns / 1ps
`default_nettype none

module fft_input #(
    parameter FFT_SIZE   = 1024,
    parameter DATA_WIDTH = 24,       // Width of I2S data
    parameter AXIS_WIDTH = 48,       // Width of FFT Input container
    parameter CFG_WIDTH  = 16        // Configuration Channel Width
)(
    input wire clk,
    input wire resetn,

    // FIFO Interface (MUST BE FWFT MODE)
    input wire [DATA_WIDTH-1:0] fifo_data,
    input wire fifo_empty,
    output reg fifo_rd_en,

    // FFT Data Interface
    output reg [AXIS_WIDTH-1:0] m_axis_data_tdata,
    output reg m_axis_data_tvalid,
    output wire m_axis_data_tlast,   // Changed to wire for precise timing
    input wire m_axis_data_tready,

    // FFT Config Interface
    output reg [CFG_WIDTH-1:0] m_axis_config_tdata,
    output reg m_axis_config_tvalid,
    input wire m_axis_config_tready
);

    // State Machine Constants
    localparam [1:0] IDLE      = 2'b00, 
                     SEND_CFG  = 2'b01, 
                     STREAMING = 2'b10;
    
    reg [1:0] state;
    reg [$clog2(FFT_SIZE)-1:0] sample_cnt;

    // Configuration Value: 
    // Bit 0 = 1 (Forward FFT)
    // Bits 1+ = Scaling schedule (if enabled in IP GUI)
    localparam [CFG_WIDTH-1:0] CFG_VALUE = 16'h0000;

    // --- State Machine ---
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= IDLE;
            sample_cnt <= 0;
            m_axis_config_tvalid <= 0;
            m_axis_config_tdata  <= CFG_VALUE;
            m_axis_data_tvalid   <= 0;
            m_axis_data_tdata    <= 0;
            fifo_rd_en           <= 0;
        end else begin
            // Default outputs (Pulse behavior for AXI-Stream)
            m_axis_config_tvalid <= 0;
            m_axis_data_tvalid   <= 0;
            fifo_rd_en           <= 0;

            case (state)
                // 1. Wait for Reset to clear
                IDLE: begin
                    state <= SEND_CFG;
                end

                // 2. Send Configuration to FFT (Required to "wake up" the IP)
                SEND_CFG: begin
                    m_axis_config_tvalid <= 1;
                    m_axis_config_tdata  <= CFG_VALUE;
                    if (m_axis_config_tready) begin
                        state <= STREAMING;
                    end
                end

                // 3. Move data from FIFO to FFT
                STREAMING: begin
                    // Handshake: We have data AND the FFT is ready to take it
                    if (!fifo_empty && m_axis_data_tready) begin
                        fifo_rd_en         <= 1;
                        m_axis_data_tvalid <= 1;
                        
                        // Data Formatting: {Imaginary (16-bit 0), Real (16-bit Audio)}
                        // We take the top 16 bits of your 24-bit audio for the FFT input
                        m_axis_data_tdata  <= { 24'd0, fifo_data[23:0] };

                        // Manage the frame counter
                        if (sample_cnt == FFT_SIZE - 1) begin
                            sample_cnt <= 0;
                        end else begin
                            sample_cnt <= sample_cnt + 1;
                        end
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

    // --- TLAST Generation ---
    // In AXI-Stream, TLAST must be high AT THE SAME TIME as the 1024th TVALID.
    // Using a continuous assign ensures there is no 1-clock delay.
    assign m_axis_data_tlast = (state == STREAMING) && 
                               (sample_cnt == FFT_SIZE - 1) && 
                               (!fifo_empty && m_axis_data_tready);

endmodule
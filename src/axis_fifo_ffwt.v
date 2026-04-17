`timescale 1ns / 1ps
`default_nettype none

module axis_fifo_fwft #(
    parameter ADDR_WIDTH = 11, // 2048 entries to safely buffer 1024-pt frames
    parameter DATA_WIDTH = 24,
    parameter FFT_SIZE   = 1024
)(
    input wire clk,
    input wire resetn,

    // Slave Interface (Input from Volume Controller)
    input  wire [DATA_WIDTH-1:0] s_axis_tdata,
    input  wire                  s_axis_tvalid,
    output wire                  s_axis_tready,

    // Master Interface (Output to FFT Input/IP)
    output wire [DATA_WIDTH-1:0] m_axis_tdata,
    output wire                  m_axis_tvalid,
    output wire                  m_axis_tlast,
    input  wire                  m_axis_tready
);

    reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];
    reg [ADDR_WIDTH-1:0] wr_ptr = 0;
    reg [ADDR_WIDTH-1:0] rd_ptr = 0;
    reg [ADDR_WIDTH:0]   count  = 0;

    // --- NEW: Sample Counter for TLAST ---
    // This tracks which sample of the 1024-block we are currently reading
    reg [9:0] read_sample_cnt = 0; 

    // --- Internal Status ---
    wire full  = (count == 2**ADDR_WIDTH);
    wire empty = (count == 0);

    // --- Write Logic ---
    always @(posedge clk) begin
        if (!resetn) begin
            wr_ptr <= 0;
        end else if (s_axis_tvalid && s_axis_tready) begin
            mem[wr_ptr] <= s_axis_tdata;
            wr_ptr <= wr_ptr + 1;
        end
    end

    // --- Read Logic & TLAST Counter ---
    always @(posedge clk) begin
        if (!resetn) begin
            rd_ptr <= 0;
            read_sample_cnt <= 0;
        end else if (m_axis_tvalid && m_axis_tready) begin
            rd_ptr <= rd_ptr + 1;
            
            // Increment the frame counter every time a sample is accepted by the FFT
            if (read_sample_cnt == FFT_SIZE - 1)
                read_sample_cnt <= 0;
            else
                read_sample_cnt <= read_sample_cnt + 1;
        end
    end

    // --- Count Tracker (Fixed simultaneous R/W) ---
    always @(posedge clk) begin
        if (!resetn) begin
            count <= 0;
        end else begin
            case ({ (s_axis_tvalid && s_axis_tready), (m_axis_tvalid && m_axis_tready) })
                2'b10: count <= count + 1;
                2'b01: count <= count - 1;
                default: count <= count; // Handles 00 and 11 (simultaneous R/W)
            endcase
        end
    end

    // --- AXI-Stream Logic ---
    assign s_axis_tready = !full;
    assign m_axis_tvalid = !empty;
    assign m_axis_tdata  = mem[rd_ptr];

    // --- FIXED TLAST ---
    // TLAST must be high ONLY when the 1024th sample is being presented AND data is valid
    assign m_axis_tlast  = (m_axis_tvalid) && (read_sample_cnt == FFT_SIZE - 1);

endmodule
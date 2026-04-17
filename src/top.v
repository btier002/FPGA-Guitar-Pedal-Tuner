`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc
// Engineer: Arthur Brown
// 
// Create Date: 03/23/2018 11:53:54 AM
// Design Name: Arty-A7-100-Pmod-I2S2
// Module Name: top
// Project Name: 
// Target Devices: Arty A7 100
// Tool Versions: Vivado 2017.4
// Description: Implements a volume control stream from Line In to Line Out of a Pmod I2S2 on port JA
// 
// Revision:
// Revision 0.01 - File Created
// 
//////////////////////////////////////////////////////////////////////////////////


module top #(
	parameter NUMBER_OF_SWITCHES = 16,
	parameter RESET_POLARITY = 0,
	parameter INDEX_WIDTH = 11,
	parameter FREQ_WIDTH = INDEX_WIDTH + 16
) (
    input wire       clk,
    input wire [NUMBER_OF_SWITCHES-1:0] sw,
    input wire       reset,
    input wire       btn0,
    output wire [15:0] led,
    output wire [3:0] an,
    output wire [6:0] seg,
    
    output wire tx_mclk,
    output wire tx_lrck,
    output wire tx_sclk,
    output wire tx_data,
    output wire rx_mclk,
    output wire rx_lrck,
    output wire rx_sclk,
    input  wire rx_data
    
    /*output wire amp,
    output wire enable*/
    
);
    wire axis_clk;
    wire resetn = ~reset;    
    wire [23:0] axis_tx_data;
    wire axis_tx_valid;
    wire axis_tx_ready;
    wire axis_tx_last;
    
    wire [23:0] axis_rx_data;
    wire axis_rx_valid;
    wire axis_rx_ready;
    wire axis_rx_last;
    
    //////
    //FIFO to FFT_INPUT
    wire left_chan_valid = axis_tx_valid && !axis_tx_last;    
    wire [23:0] fifo_to_fft_data;
    wire        fifo_to_fft_valid;
    wire        fft_req_read;
    ///////////////////////
    //DOWNSTREAMING
    //IN
    wire m_axis_config_tready;
    
    wire m_axis_data_tready = 1'b1;
    //OUT
    wire [31:0] m_axis_data_tdata;
    wire m_axis_data_tvalid;
    wire m_axis_data_tlast;
    wire [15:0] m_axis_config_tdata;
    wire m_axis_config_tvalid;
    wire fifo_rd_en;
    ///////////////////////
        
    //IN
    wire s_axis_data_tready;
    
    //OUT
	wire [23:0] real_fft;
	wire TLAST_FFT_Block;
	wire TVALID_FFT_Block;
    
    wire event_tlast_missing;
    wire event_tlast_unexpected;
    
    
    //Peak Detector
    ///??????
    wire [31:0] peak_mag;
    wire [INDEX_WIDTH-1:0] peak_index;
    wire        peak_valid;
    wire fft_ready_out;
    
    wire freq_out_valid;
    wire [FREQ_WIDTH-1:0] freq_out;
    
	
    clk_wiz_0 m_clk (
        .clk_in1(clk),
        .axis_clk(axis_clk)
    );
    
    axis_i2s2 m_i2s2 (
        .axis_clk(axis_clk),
        .axis_resetn(resetn),
        
        //IN
        
        .tx_axis_s_data(axis_tx_data),
        .tx_axis_s_valid(axis_tx_valid),
        .tx_axis_s_ready(axis_tx_ready),
        .tx_axis_s_last(axis_tx_last),
        
        .rx_sdin(rx_data),
        
        //OUT
        .rx_axis_m_data(axis_rx_data),
        .rx_axis_m_valid(axis_rx_valid),
        .rx_axis_m_ready(axis_rx_ready),
        .rx_axis_m_last(axis_rx_last),
        
        .tx_mclk(tx_mclk),
        .tx_lrck(tx_lrck),
        .tx_sclk(tx_sclk),
        .tx_sdout(tx_data),
        .rx_mclk(rx_mclk),
        .rx_lrck(rx_lrck),
        .rx_sclk(rx_sclk)

    );
      
    axis_volume_controller #(
		.DATA_WIDTH(24)
	) m_vc (
        .clk(axis_clk),
        
        .s_axis_data(axis_rx_data),
        .s_axis_valid(axis_rx_valid),
        .s_axis_ready(axis_rx_ready),
        .s_axis_last(axis_rx_last),
        
        .m_axis_data(axis_tx_data),
        .m_axis_valid(axis_tx_valid),
        .m_axis_ready(axis_tx_ready),
        .m_axis_last(axis_tx_last)
    );
    
    axis_fifo_fwft #(
        .ADDR_WIDTH(11), 
        .DATA_WIDTH(24),
        .FFT_SIZE(1024)
    ) audio_buffer (
        .clk(axis_clk),
        .resetn(resetn),
        
        // Input side (from Volume Controller)
        .s_axis_tdata(axis_tx_data),
        .s_axis_tvalid(left_chan_valid),     // Use the filtered valid signal
        .s_axis_tready(1'b1),
        
        // Output side (to fft_input)
        .m_axis_tdata(m_axis_data_tdata),
        .m_axis_tvalid(m_axis_data_tvalid),
        .m_axis_tready(s_axis_data_tready),        // Driven by fft_input_i.fifo_rd_en
        .m_axis_tlast(m_axis_data_tlast)
        
        // Config side
        /*.m_axis_config_tdata(m_axis_config_tdata),
        .m_axis_config_tvalid(m_axis_config_tvalid),
        .m_axis_config_tready(m_axis_config_tready)*/
    );
    
    /*fft_input #(
        .FFT_SIZE(1024),
        .DATA_WIDTH(24),
        .AXIS_WIDTH(32),
        .CFG_WIDTH(16)
    ) fft_input_i (
        .clk(axis_clk),
        .resetn(resetn),
        
        // Input from our FWFT FIFO
        .fifo_data(fifo_to_fft_data),      // Connection from FIFO m_axis_tdata
        .fifo_empty(fifo_to_fft_valid),   // Empty if FIFO m_axis_tvalid is low
        .fifo_rd_en(fft_req_read),         // Controls the FIFO read pointer
        
        // FFT Config Interface
        .m_axis_config_tdata(m_axis_config_tdata),
        .m_axis_config_tvalid(m_axis_config_tvalid),
        .m_axis_config_tready(m_axis_config_tready),
        
        // FFT Data Interface
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_data_tlast(m_axis_data_tlast),
        .m_axis_data_tready(s_axis_data_tready) 
    );*/

    fft_design fft_design_i (
        //From HDL Wrapper
        .fft_ready_out(1'b1),
        
        .m_axis_config_tdata(16'h0001),
        .m_axis_config_tvalid(1'b1),
        .m_axis_config_tready(m_axis_config_tready),

        .m_axis_data_tdata(m_axis_data_tdata),   
        .m_axis_data_tvalid(m_axis_data_tvalid), 
        .m_axis_data_tlast(m_axis_data_tlast),
        .m_axis_data_tready(s_axis_data_tready),
                     
        .TVALID_FFT_Block(TVALID_FFT_Block),     
        .TLAST_FFT_Block(TLAST_FFT_Block),       
        .real_fft(real_fft),
        .event_tlast_unexpected(event_tlast_unexpected),
        .event_tlast_missing(event_tlast_missing)
    );
    
    ila_test ila_test_i (
        .clk(axis_clk),
        .probe0(real_fft),
        .probe1(m_axis_data_tready),
        .probe2(s_axis_data_tready)
        );
    /*ila_test ila_test_i (
        .clk(axis_clk),
        .probe0(axis_rx_data),
        .probe1(axis_rx_ready),
        .probe2(axis_rx_valid)
        );*/
        
    ila_test_2 ila_test_2_i (
        .clk(axis_clk),
        .probe0(axis_rx_valid),
        .probe1(m_axis_config_tvalid),
        .probe2(m_axis_config_tready),
        .probe3(m_axis_data_tlast)
        );
        
    /*
    ila_1 tx_ila (
    .clk(axis_clk),           
    .probe0(m_axis_data_tlast),   
    .probe1(m_axis_data_tlast), 
    .probe2(m_axis_data_tready),   
    .probe3(axis_tx_valid),   
    .probe4(axis_tx_ready),
    .probe5(TVALID_FFT_Block),
    .probe6(TLAST_FFT_Block)
)*/
    
    /*
    ila_2 ila_2_i (
     .clk(axis_clk),
     .probe0(TVALID_FFT_Block),
     .probe1(TLAST_FFT_Block),
     .probe2(peak_mag),
     .probe3(peak_index),
     .probe4(peak_valid)
     );*/
    
    
    peak_detector peak_detector_i (
    .clk(axis_clk),
    .reset(resetn),
    .fft_magnitude_in(real_fft),
    .valid_in(TVALID_FFT_Block),
    .frame_start(TLAST_FFT_Block),
    
    .fft_ready_out(fft_ready_out),
    .peak_magnitude_out(peak_mag),
    .peak_index_out(peak_index),
    .peak_valid_out(peak_valid)
    );
    
    frequency_calc frequency_calc_to_cents_i (
    .clk(axis_clk),
    .reset(resetn),
    .peak_index_in(peak_index),
    .peak_valid_in(peak_valid),
    
    .dominant_freq_out(freq_out),
    .freq_out_valid(freq_out_valid)
    );
    
    
    wire [15:0] tuner_leds; 
    tuner tuner_i (
    .clk(axis_clk),
    .reset(resetn),
    .led(tuner_leds),
    .freq_in(freq_out),
    .freq_valid(freq_out_valid),
    .an(an),
    .seg(seg)
    );
    
    //LED DEBUG
    // --- DEBUG LED LOGIC ---
reg [31:0] frame_count;
reg data_seen_at_input;
reg data_seen_at_output;
reg data_seen_at_fft_input;
reg after_input;
reg config_ready;
always @(posedge axis_clk) begin
    if (!resetn) begin
        data_seen_at_input  <= 0;
        data_seen_at_output <= 0;
        frame_count         <= 0;
        data_seen_at_fft_input <= 0;
        after_input <= 0;
        config_ready <= 0;
    end else begin
        // LED 15: Did the Volume Controller send anything to the FIFO?
        if (left_chan_valid) data_seen_at_input <= 1;
        
        // LED 14: Did the FFT actually produce a valid result?
        if (TVALID_FFT_Block) data_seen_at_output <= 1;
        
        // LED 13: Toggle every time a full 1024-pt frame finishes
        if (TLAST_FFT_Block && TVALID_FFT_Block) frame_count <= frame_count + 1;
        
        if (m_axis_data_tvalid) after_input <= 1;
        
        if (m_axis_config_tready) config_ready <= 1;
    end
end

assign led[0]  = data_seen_at_input;  // Debug: Input exists
assign led[1]  = data_seen_at_output; // Debug: FFT works
assign led[2]  = config_ready;    // Debug: FFT ready
assign led[4] = after_input;
assign led[5] = event_tlast_missing || event_tlast_unexpected;
assign led[15:8] = tuner_leds[15:8];      // Give the rest to the Tuner
                
endmodule

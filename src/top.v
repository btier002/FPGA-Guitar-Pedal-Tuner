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
    wire resetn = (reset == RESET_POLARITY) ? 1'b0 : 1'b1;
    
    wire [23:0] axis_tx_data;
    wire axis_tx_valid;
    wire axis_tx_ready;
    wire axis_tx_last;
    
    wire [23:0] axis_rx_data;
    wire axis_rx_valid;
    wire axis_rx_ready;
    wire axis_rx_last;

	wire [31:0] ABS_FFT;
    wire TLAST_FFT_Block;
    wire TVALID_FFT_Block;
    
    //Peak Detector
    wire [31:0] peak_mag;
    wire [INDEX_WIDTH-1:0] peak_index;
    wire        peak_valid;
    
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
		.SWITCH_WIDTH(NUMBER_OF_SWITCHES),
		.DATA_WIDTH(24)
	) m_vc (
        .clk(axis_clk),
        .sw(sw),
        
        .s_axis_data(axis_rx_data),
        .s_axis_valid(axis_rx_valid),
        .s_axis_ready(axis_rx_ready),
        .s_axis_last(axis_rx_last),
        
        .m_axis_data(axis_tx_data),
        .m_axis_valid(axis_tx_valid),
        .m_axis_ready(axis_tx_ready),
        .m_axis_last(axis_tx_last)
    );

    // FFT input stream data (from new packetizer)
    wire [31:0] fft_in_tdata;
    wire        fft_in_tvalid;
    wire        fft_in_tlast;
    wire        fft_in_tready;

    fft_input #(
        .FFT_SIZE(2048)
    ) fft_input_i (
        .clk(axis_clk),
        .reset(resetn),
    
        .sample_in(axis_tx_data),      // 24-bit audio from volume controller
        .sample_valid(axis_tx_valid),
        .sample_ready(fft_in_tready),
    
        .tdata(fft_in_tdata),          // 32-bit complex
        .tvalid(fft_in_tvalid),
        .tlast(fft_in_tlast),
        .tready(fft_in_tready)
    );

    fft_design fft_design_i (
        .ABS_FFT(ABS_FFT),
        .TLAST_FFT_Block(TLAST_FFT_Block),
        .TVALID_FFT_Block(TVALID_FFT_Block),
        .m_axis_data_tready(1'b1),
        
        .axis_clk(axis_clk),
        .s_axis_data(fft_in_tdata),
        .s_axis_last(fft_in_tlast),
        .s_axis_valid(fft_in_tvalid),
        .s_axis_ready(fft_in_tready)
    );
    
    ila_1 tx_ila (
    .clk(axis_clk),           
    .probe0(fft_in_tlast),   
    .probe1(fft_in_tvalid), 
    .probe2(fft_in_tready),   
    .probe3(axis_tx_valid),   
    .probe4(axis_tx_ready),
    .probe5(TVALID_FFT_Block),
    .probe6(TLAST_FFT_Block)
);

    ila_2 ila_2_i (
     .clk(axis_clk),
     .probe0(TVALID_FFT_Block),
     .probe1(TLAST_FFT_Block),
     .probe2(peak_mag),
     .probe3(peak_index),
     .probe4(peak_valid)
     );
    
    peak_detector peak_detector_i (
    .clk(axis_clk),
    .reset(resetn),
    .fft_magnitude_in(ABS_FFT),
    .valid_in(TVALID_FFT_Block),
    .frame_start(TLAST_FFT_Block),
    
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
    
    tuner tuner_i (
    .clk(axis_clk),
    .reset(resetn),
    .led(led),
    .freq_in(freq_out),
    .freq_valid(freq_out_valid),
    .an(an),
    .seg(seg)
    );
                
endmodule

//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Sat Jan 10 21:07:19 2026
//Host        : Alamos running 64-bit major release  (build 9200)
//Command     : generate_target fft_design_wrapper.bd
//Design      : fft_design_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module fft_design_wrapper
   (TLAST_FFT_Block,
    TVALID_FFT_Block,
    axis_clk,
    m_axis_data_tready,
    real_fft,
    s_axis_data,
    s_axis_last,
    s_axis_ready,
    s_axis_valid);
  output TLAST_FFT_Block;
  output TVALID_FFT_Block;
  input axis_clk;
  input m_axis_data_tready;
  output [15:0]real_fft;
  input s_axis_data;
  input s_axis_last;
  output s_axis_ready;
  input s_axis_valid;

  wire TLAST_FFT_Block;
  wire TVALID_FFT_Block;
  wire axis_clk;
  wire m_axis_data_tready;
  wire [15:0]real_fft;
  wire s_axis_data;
  wire s_axis_last;
  wire s_axis_ready;
  wire s_axis_valid;

  fft_design fft_design_i
       (.TLAST_FFT_Block(TLAST_FFT_Block),
        .TVALID_FFT_Block(TVALID_FFT_Block),
        .axis_clk(axis_clk),
        .m_axis_data_tready(m_axis_data_tready),
        .real_fft(real_fft),
        .s_axis_data(s_axis_data),
        .s_axis_last(s_axis_last),
        .s_axis_ready(s_axis_ready),
        .s_axis_valid(s_axis_valid));
endmodule

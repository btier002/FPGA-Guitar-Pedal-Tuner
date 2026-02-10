//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Sat Jan 10 21:07:19 2026
//Host        : Alamos running 64-bit major release  (build 9200)
//Command     : generate_target fft_design.bd
//Design      : fft_design
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "fft_design,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=fft_design,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=3,da_clkrst_cnt=5,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "fft_design.hwdef" *) 
module fft_design
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
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AXIS_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AXIS_CLK, CLK_DOMAIN fft_design_axis_clk, FREQ_HZ 44000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input axis_clk;
  input m_axis_data_tready;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.REAL_FFT DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.REAL_FFT, LAYERED_METADATA undef" *) output [15:0]real_fft;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.S_AXIS_DATA DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.S_AXIS_DATA, LAYERED_METADATA undef" *) input s_axis_data;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.S_AXIS_LAST DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.S_AXIS_LAST, LAYERED_METADATA undef" *) input s_axis_last;
  output s_axis_ready;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.S_AXIS_VALID DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.S_AXIS_VALID, LAYERED_METADATA undef" *) input s_axis_valid;

  wire TLAST_FFT_Block;
  wire TVALID_FFT_Block;
  wire axis_clk;
  wire [31:0]c_addsub_0_S;
  wire m_axis_data_tready;
  wire [31:0]mult_gen_0_P;
  wire [31:0]mult_gen_1_P;
  wire [15:0]real_fft;
  wire s_axis_data;
  wire s_axis_last;
  wire s_axis_ready;
  wire s_axis_valid;
  wire [31:0]xfft_0_m_axis_data_tdata;
  wire [15:0]xlslice_0_Dout;
  wire [15:0]xlslice_1_Dout;

  fft_design_c_addsub_0_0 c_addsub_0
       (.A(mult_gen_0_P),
        .B(mult_gen_1_P),
        .CLK(axis_clk),
        .S(c_addsub_0_S));
  fft_design_mult_gen_0_0 mult_gen_0
       (.A(xlslice_0_Dout),
        .B(xlslice_0_Dout),
        .CLK(axis_clk),
        .P(mult_gen_0_P));
  fft_design_mult_gen_1_0 mult_gen_1
       (.A(xlslice_1_Dout),
        .B(xlslice_1_Dout),
        .CLK(axis_clk),
        .P(mult_gen_1_P));
  fft_design_xfft_0_0 xfft_0
       (.aclk(axis_clk),
        .m_axis_data_tdata(xfft_0_m_axis_data_tdata),
        .m_axis_data_tlast(TLAST_FFT_Block),
        .m_axis_data_tready(m_axis_data_tready),
        .m_axis_data_tvalid(TVALID_FFT_Block),
        .s_axis_config_tdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axis_config_tvalid(1'b0),
        .s_axis_data_tdata({s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data,s_axis_data}),
        .s_axis_data_tlast(s_axis_last),
        .s_axis_data_tready(s_axis_ready),
        .s_axis_data_tvalid(s_axis_valid));
  fft_design_xlslice_0_0 xlslice_0
       (.Din(xfft_0_m_axis_data_tdata),
        .Dout(xlslice_0_Dout));
  fft_design_xlslice_1_0 xlslice_1
       (.Din(xfft_0_m_axis_data_tdata),
        .Dout(xlslice_1_Dout));
  fft_design_xlslice_2_0 xlslice_2
       (.Din(c_addsub_0_S),
        .Dout(real_fft));
endmodule

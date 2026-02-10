// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module fft_design (
  TVALID_FFT_Block,
  TLAST_FFT_Block,
  s_axis_data,
  s_axis_valid,
  s_axis_last,
  axis_clk,
  s_axis_ready,
  m_axis_data_tready,
  real_fft
);

  (* X_INTERFACE_IGNORE = "true" *)
  output TVALID_FFT_Block;
  (* X_INTERFACE_IGNORE = "true" *)
  output TLAST_FFT_Block;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.S_AXIS_DATA DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.S_AXIS_DATA" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.S_AXIS_DATA, LAYERED_METADATA undef" *)
  input s_axis_data;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.S_AXIS_VALID DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.S_AXIS_VALID" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.S_AXIS_VALID, LAYERED_METADATA undef" *)
  input s_axis_valid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.S_AXIS_LAST DATA" *)
  (* X_INTERFACE_MODE = "slave DATA.S_AXIS_LAST" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.S_AXIS_LAST, LAYERED_METADATA undef" *)
  input s_axis_last;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.AXIS_CLK CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.AXIS_CLK" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.AXIS_CLK, FREQ_HZ 44000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN fft_design_axis_clk, INSERT_VIP 0" *)
  input axis_clk;
  (* X_INTERFACE_IGNORE = "true" *)
  output s_axis_ready;
  (* X_INTERFACE_IGNORE = "true" *)
  input m_axis_data_tready;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.REAL_FFT DATA" *)
  (* X_INTERFACE_MODE = "master DATA.REAL_FFT" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.REAL_FFT, LAYERED_METADATA undef" *)
  output [15:0]real_fft;

  // stub module has no contents

endmodule

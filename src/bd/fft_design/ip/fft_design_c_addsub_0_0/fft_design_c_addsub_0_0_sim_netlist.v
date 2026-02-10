// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Sun Oct 19 14:44:07 2025
// Host        : Alamos running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top fft_design_c_addsub_0_0 -prefix
//               fft_design_c_addsub_0_0_ fft_design_c_addsub_0_0_sim_netlist.v
// Design      : fft_design_c_addsub_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "fft_design_c_addsub_0_0,c_addsub_v12_0_19,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_19,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module fft_design_c_addsub_0_0
   (A,
    B,
    CLK,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_mode = "slave a_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency bitwidth format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type generated dependency signed format bool minimum {} maximum {}} value TRUE}}}} DATA_WIDTH 32}" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_mode = "slave b_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency bitwidth format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type generated dependency signed format bool minimum {} maximum {}} value TRUE}}}} DATA_WIDTH 32}" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_mode = "slave clk_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 44000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN fft_design_axis_clk, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_mode = "master s_intf" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency bitwidth format long minimum {} maximum {}} value 32} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type generated dependency signed format bool minimum {} maximum {}} value TRUE}}}} DATA_WIDTH 32}" *) output [31:0]S;

  wire [31:0]A;
  wire [31:0]B;
  wire CLK;
  wire [31:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_a_type = "0" *) 
  (* c_a_width = "32" *) 
  (* c_add_mode = "0" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "0" *) 
  (* c_b_value = "00000000000000000000000000000000" *) 
  (* c_b_width = "32" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "32" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  fft_design_c_addsub_0_0_c_addsub_v12_0_19 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oeiSycU/+UTHUctAP/1EG0ARA7oWt+xFQ9F10RrtHn5SZO+NXJ2Sm1lpLWPVfe/IDP9GV69i1poN
BhSAs1MJDIQLH5itROLuDXYYF/elSJEMeT/k73s+GON1baIJHccZb15U9aChMHgHXrYpoUMUrHTj
cWKmcYvrvycsSZ0Ngj0=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qORY6ws3UX1BZqnQJ1io0G9Nj1mDoEV6ROyL+jga0TOnG+bD0DFym5LX2wB5jhQI/eRptItp6+Xw
3dz9zFmq8NXFF+H+NoAKmelb5s1UO1+nfsrEsY8jRSPwzzSzuTFf9OtMNFu42aJmeH09lBQfBPMd
0g8oj4NEftYfLjmarR5bIjHb/GieQEuAG4o3tNixOIZPopFrEcLQmXA0/6Si94XRfX8SGit/uPiX
Cm3Ld7fjVMOIf5S5tOgoEZwsHYzMx0XvK3i+9QPsCeqsuebvotwtKvZDSmshdCRoRGC2h/2yNcZl
ec51FkbmEd1je49PLDVQ8/qLCS6k38XKHO3MBQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lmkJZn2yha+73EQxzvf2ftjA2ZPsXiOCU7WmgNFhW/A6MvolqZ8LDAIchWnJc/ZHbIScX4wfK6+7
nDmo6Gs7JUBsq8skyRrsRz+cU89cm9KQWXWgtduzrbZnLzKX46ZgLyQglaYI6K3bULnKfCjO8SLR
LtNR6Q2KaQzjkJvk6SQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eUZvqSLYSMj/GdGxHahsqEMos5RJfJi42gE7cSTGksQEWHG4i3FQfGZX1wHlW544I/vgSbV+T81a
VLBgL8TiR93gf3RM05BCx8hCdksptudNbJ1B+4bvi8ZUhlGzurVccrLFZwFViff1f7GRdvDjzWaC
gOP2Ljbv4XRXnLGH2pxiBcZOMaKwAlxIvD4LazzzRpctyr2JFmoxUvEo+YztJYzUGHSBsEtnzBtd
J7yR39/fIvbDUpo/EHHYPEgeKU4TqN311PIFFg4H/jMgjESY+COMLQNxYMNBoLECrtgjYfOa0o2M
cChrq3YEH96IEyG8GPIv/BrjL3zNOZfog2sp8w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
K26hlSK1EjbroYKyAOeyuiAeDIHUk71YecuhEaZditw+NrpQu3KoUAiuicPSmI1CMdSZyYBxyLV5
1zZW6PAXj/jSMlODXEo5cpb86txEmESnLjH9zpgRiRvN5tSxGAIHxnuwOlqT6Oqsyek5yoTywyTz
lAjGwIvXleEv832/9ERcxAFOPqeI5aKS39t+VTcC9fhAnvrMTACqwFgkEWl8O5l0B5tK49ogIRlj
NmgVEAnTph1Jz2k5wajNZccl3LPj/11FbVllMHM8UV3jR/Jn21gWOnBcc+Z55sGeUvOMdOXuv1gX
OU8m9JenUD3vWSVeyg3klIRuYc+H8lLDlxT70Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bzXdP1pGOW3mmxgqQfwXHtnVzDGC/wEa2NlskilDjfkNQUN5CsHuexL9ELnpc4xM656F9IQy3qdN
piNJKaCQxyCFaAKUELbM5o+y8sbqpyVb7p+1PEkmVqZEX6WN4hWeKD20/nlshmC7fHDGYRDOFHQv
UVCqnndg8GmguGkFVlc6xNb0DB+UFIUeMVxsbRC3c+5xuIKlUpf3xO2wJ2JMcHsGoGExA5jDpVtC
XUb6lRjP6FQKVPpHxVM43BDo4meN0J4mZJgJ6Y0NGl7p2hIpw2B3FUeCsGuMBHa1yyjtbeaYm04V
ZtsEdxqhatDH6Hbh1HmBYUrqB5AWn0IQCFBcJw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
E9YZrDeBcNG88vADiIeQq98M+D+IK5O8qKdsAiqH8H2Vq6CihreD0CvL8FNmEeeK29hS1YcWPCIM
Vwii1zmOvyMg70UBVcqHUSHSCU+9gUfFtXhbceEsyGvflmbTqPLzIQv4+JAixbrvmdtDkAnrgBBb
mP2pUJpAbd2EJ5aSksRcY7nZxv/9/cPYiDfnGma6GIwsGcVmEfX45fEWszsNE5cuwZ9mDYww+Wwr
4TQ7mHobAuu8bFp870HEVz691DIkWHFCis3+2xdsOqJFwFIrNbUTXpJyDq7aB1bMVpfsWFJiR/nd
m7QGmvoxXtZB4099VGFkmiRQoe43NF881HmROg==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
XWIUz3r9K8YdMNtaDPZkHe/sQ6BdHgzj6ek4zBJS2bZbt+F9Uuu0cDLJ/G4cMqkL7Euw5Tyy09Ba
kqvksnSP/Q34/hUL6lgViALqcO5b4oL7wuCqzJ7ghXQ7IOU3kPn/zDkXZ53Xf4RQCR8EYWxobBcX
C5jBL3Ra174J3ZNpwK8jSxkoH/zXfIy7YzwVkOK3sfYyiBROekX3pLu52dooP6VCZeGDVfZQi3ki
2QUbldTjM807egjriAka63+4cLzrlil3HjPPhJ1jsWqpP/b1pEPDjtfRt3qRC6q01mbnuQhJc/Qp
fWZoKt6T5F5FHmAdb9HwiGfxQmOXxTXiCCN8OgZnNOOeGEloQoB/OjByD+bzq9D3fGzHZOidm7xG
YeiwIX+r8L4p7fPa8tXtyzbTQD+doc9JsPYl2eweVHAqvXFUQRL17bAsxW3MsaLOJa/77ZbTBkvx
vitvirW0oMKOGwQ9n/yo7LteTENDBnMrmNJhoklTavuV+XSZqje0USVQ

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YZ//P+GUHQDqpn2u7+vaRR/n6pkgMcX0ltpdiACAy9T1rY9/JIRYQaB0jbllhOrQAppfK9GfyabA
0PpVWsb2l42OnLoZg5rlWo6g+aaOAe8Vii++hndQmXs9M3gbv6lUmrE7P+u/8LdmuRaPzEUnFJeH
tn1O3IjnizGIsbwnD7lPOtetKIA0X9BIdwHx0x4vH845vPXdzz210rc/Y/PP6NN8uHzxeYaE5s0w
sr29XI9ibUMV07reHGJOZbiAbzzUMELVDuLeHFra4b1zriwCUVbeax/RhTcNggdKjbcpjo8HT/yW
IHglsLc4qAt3aTStevZ4b03narZeDNBHdSPhrw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EsSOcM2Ymz4XVAa0+f0dwPkTVaLSDSU6b/FPqA/TuuKf9X+OY4I0pT12//yNB5tSSxRW6aTsvpFT
isjZq3EDfIjvVzkFvRB+gAIJfFLUz+wE9HMbvrIkVpouAIjjjiXwQyX/8bF/8wN6QhWAr327PE94
OSYhfM22sNAfyr/tpX0BQe6zkO7I8wC8s0A+XHMDHmzfCA0ACcTwMhv7Hn4O4lBQbqhlGpdCY2T+
IhGXWCY/rXETUI/myVT4br4jxSFqQajZotIjycwHFeS+Gb3eUaXY+5Bsm8X3WAWW5RZiecGzoND7
uha2V8ClYn3Z9DcxmKp8nJn08TwK97bL98hxwg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OApFoHJ3RKPX62eyc4yYtb5WJ3Qq2xS6L7LmVy1hGXfeO5s98jlGjNSDa+MYB7Vj9QU2mlejnFqT
EtDgJngAQuR4gPz6gdKAvARnH9/YyO/8gmkUmHvHhHOZdeho5P9VUagspwSb9O51a3yP+ubv3Jd6
7K7oHXPeFume77AEP0tsCheh0r/9IkwWu4CrETL/Xccob5Am5wEp6fStopqDNThZsQu/i+9Id10z
/nuVz+nBzYgcU1zL1FZfKrKqATGivEVsKDaY8Hhy/z2COk6iT9/5HLY2QTXDn6npr2PzbZXt7vyW
E9/1Op+Z8E+6CnWp1HXH4uMJGVTS6Kr6yGU60Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2640)
`pragma protect data_block
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
75Nxvpm9G5UIDWQSGGQepy6q
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oeiSycU/+UTHUctAP/1EG0ARA7oWt+xFQ9F10RrtHn5SZO+NXJ2Sm1lpLWPVfe/IDP9GV69i1poN
BhSAs1MJDIQLH5itROLuDXYYF/elSJEMeT/k73s+GON1baIJHccZb15U9aChMHgHXrYpoUMUrHTj
cWKmcYvrvycsSZ0Ngj0=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qORY6ws3UX1BZqnQJ1io0G9Nj1mDoEV6ROyL+jga0TOnG+bD0DFym5LX2wB5jhQI/eRptItp6+Xw
3dz9zFmq8NXFF+H+NoAKmelb5s1UO1+nfsrEsY8jRSPwzzSzuTFf9OtMNFu42aJmeH09lBQfBPMd
0g8oj4NEftYfLjmarR5bIjHb/GieQEuAG4o3tNixOIZPopFrEcLQmXA0/6Si94XRfX8SGit/uPiX
Cm3Ld7fjVMOIf5S5tOgoEZwsHYzMx0XvK3i+9QPsCeqsuebvotwtKvZDSmshdCRoRGC2h/2yNcZl
ec51FkbmEd1je49PLDVQ8/qLCS6k38XKHO3MBQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
lmkJZn2yha+73EQxzvf2ftjA2ZPsXiOCU7WmgNFhW/A6MvolqZ8LDAIchWnJc/ZHbIScX4wfK6+7
nDmo6Gs7JUBsq8skyRrsRz+cU89cm9KQWXWgtduzrbZnLzKX46ZgLyQglaYI6K3bULnKfCjO8SLR
LtNR6Q2KaQzjkJvk6SQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
eUZvqSLYSMj/GdGxHahsqEMos5RJfJi42gE7cSTGksQEWHG4i3FQfGZX1wHlW544I/vgSbV+T81a
VLBgL8TiR93gf3RM05BCx8hCdksptudNbJ1B+4bvi8ZUhlGzurVccrLFZwFViff1f7GRdvDjzWaC
gOP2Ljbv4XRXnLGH2pxiBcZOMaKwAlxIvD4LazzzRpctyr2JFmoxUvEo+YztJYzUGHSBsEtnzBtd
J7yR39/fIvbDUpo/EHHYPEgeKU4TqN311PIFFg4H/jMgjESY+COMLQNxYMNBoLECrtgjYfOa0o2M
cChrq3YEH96IEyG8GPIv/BrjL3zNOZfog2sp8w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
K26hlSK1EjbroYKyAOeyuiAeDIHUk71YecuhEaZditw+NrpQu3KoUAiuicPSmI1CMdSZyYBxyLV5
1zZW6PAXj/jSMlODXEo5cpb86txEmESnLjH9zpgRiRvN5tSxGAIHxnuwOlqT6Oqsyek5yoTywyTz
lAjGwIvXleEv832/9ERcxAFOPqeI5aKS39t+VTcC9fhAnvrMTACqwFgkEWl8O5l0B5tK49ogIRlj
NmgVEAnTph1Jz2k5wajNZccl3LPj/11FbVllMHM8UV3jR/Jn21gWOnBcc+Z55sGeUvOMdOXuv1gX
OU8m9JenUD3vWSVeyg3klIRuYc+H8lLDlxT70Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bzXdP1pGOW3mmxgqQfwXHtnVzDGC/wEa2NlskilDjfkNQUN5CsHuexL9ELnpc4xM656F9IQy3qdN
piNJKaCQxyCFaAKUELbM5o+y8sbqpyVb7p+1PEkmVqZEX6WN4hWeKD20/nlshmC7fHDGYRDOFHQv
UVCqnndg8GmguGkFVlc6xNb0DB+UFIUeMVxsbRC3c+5xuIKlUpf3xO2wJ2JMcHsGoGExA5jDpVtC
XUb6lRjP6FQKVPpHxVM43BDo4meN0J4mZJgJ6Y0NGl7p2hIpw2B3FUeCsGuMBHa1yyjtbeaYm04V
ZtsEdxqhatDH6Hbh1HmBYUrqB5AWn0IQCFBcJw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
E9YZrDeBcNG88vADiIeQq98M+D+IK5O8qKdsAiqH8H2Vq6CihreD0CvL8FNmEeeK29hS1YcWPCIM
Vwii1zmOvyMg70UBVcqHUSHSCU+9gUfFtXhbceEsyGvflmbTqPLzIQv4+JAixbrvmdtDkAnrgBBb
mP2pUJpAbd2EJ5aSksRcY7nZxv/9/cPYiDfnGma6GIwsGcVmEfX45fEWszsNE5cuwZ9mDYww+Wwr
4TQ7mHobAuu8bFp870HEVz691DIkWHFCis3+2xdsOqJFwFIrNbUTXpJyDq7aB1bMVpfsWFJiR/nd
m7QGmvoxXtZB4099VGFkmiRQoe43NF881HmROg==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
XWIUz3r9K8YdMNtaDPZkHe/sQ6BdHgzj6ek4zBJS2bZbt+F9Uuu0cDLJ/G4cMqkL7Euw5Tyy09Ba
kqvksnSP/Q34/hUL6lgViALqcO5b4oL7wuCqzJ7ghXQ7IOU3kPn/zDkXZ53Xf4RQCR8EYWxobBcX
C5jBL3Ra174J3ZNpwK8jSxkoH/zXfIy7YzwVkOK3sfYyiBROekX3pLu52dooP6VCZeGDVfZQi3ki
2QUbldTjM807egjriAka63+4cLzrlil3HjPPhJ1jsWqpP/b1pEPDjtfRt3qRC6q01mbnuQhJc/Qp
fWZoKt6T5F5FHmAdb9HwiGfxQmOXxTXiCCN8OgZnNOOeGEloQoB/OjByD+bzq9D3fGzHZOidm7xG
YeiwIX+r8L4p7fPa8tXtyzbTQD+doc9JsPYl2eweVHAqvXFUQRL17bAsxW3MsaLOJa/77ZbTBkvx
vitvirW0oMKOGwQ9n/yo7LteTENDBnMrmNJhoklTavuV+XSZqje0USVQ

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YZ//P+GUHQDqpn2u7+vaRR/n6pkgMcX0ltpdiACAy9T1rY9/JIRYQaB0jbllhOrQAppfK9GfyabA
0PpVWsb2l42OnLoZg5rlWo6g+aaOAe8Vii++hndQmXs9M3gbv6lUmrE7P+u/8LdmuRaPzEUnFJeH
tn1O3IjnizGIsbwnD7lPOtetKIA0X9BIdwHx0x4vH845vPXdzz210rc/Y/PP6NN8uHzxeYaE5s0w
sr29XI9ibUMV07reHGJOZbiAbzzUMELVDuLeHFra4b1zriwCUVbeax/RhTcNggdKjbcpjo8HT/yW
IHglsLc4qAt3aTStevZ4b03narZeDNBHdSPhrw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EsSOcM2Ymz4XVAa0+f0dwPkTVaLSDSU6b/FPqA/TuuKf9X+OY4I0pT12//yNB5tSSxRW6aTsvpFT
isjZq3EDfIjvVzkFvRB+gAIJfFLUz+wE9HMbvrIkVpouAIjjjiXwQyX/8bF/8wN6QhWAr327PE94
OSYhfM22sNAfyr/tpX0BQe6zkO7I8wC8s0A+XHMDHmzfCA0ACcTwMhv7Hn4O4lBQbqhlGpdCY2T+
IhGXWCY/rXETUI/myVT4br4jxSFqQajZotIjycwHFeS+Gb3eUaXY+5Bsm8X3WAWW5RZiecGzoND7
uha2V8ClYn3Z9DcxmKp8nJn08TwK97bL98hxwg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OApFoHJ3RKPX62eyc4yYtb5WJ3Qq2xS6L7LmVy1hGXfeO5s98jlGjNSDa+MYB7Vj9QU2mlejnFqT
EtDgJngAQuR4gPz6gdKAvARnH9/YyO/8gmkUmHvHhHOZdeho5P9VUagspwSb9O51a3yP+ubv3Jd6
7K7oHXPeFume77AEP0tsCheh0r/9IkwWu4CrETL/Xccob5Am5wEp6fStopqDNThZsQu/i+9Id10z
/nuVz+nBzYgcU1zL1FZfKrKqATGivEVsKDaY8Hhy/z2COk6iT9/5HLY2QTXDn6npr2PzbZXt7vyW
E9/1Op+Z8E+6CnWp1HXH4uMJGVTS6Kr6yGU60Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 22016)
`pragma protect data_block
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
kD8tJQKPzghqjgSJHoM=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

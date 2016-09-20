// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Sun Sep 11 16:11:54 2016
// Host        : Bonnie running 64-bit Fedora release 24 (Twenty Four)
// Command     : write_verilog -force -mode synth_stub
//               /home/batnam/lab-2/lab-2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_in1, clk_25M, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_25M,reset,locked" */;
  input clk_in1;
  output clk_25M;
  input reset;
  output locked;
endmodule

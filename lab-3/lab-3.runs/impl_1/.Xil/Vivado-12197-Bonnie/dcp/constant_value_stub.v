// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module constant_value(switch, clk, sync, d0, sclk);
  input [7:0]switch;
  input clk;
  output sync;
  output d0;
  output sclk;
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nam Tran Ngoc
// Mailbox: 388
// 
// Create Date: 09/14/2016 07:42:14 PM
// Design Name: 
// Module Name: lab2_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: vga_display, dec_counter, light_sensor, seven_seg 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: I'm tired :(
// 
//////////////////////////////////////////////////////////////////////////////////


module lab2_top(
    input [2:0] switch,
    input clk,
    output [6:0] led,
    output [3:0] an,
    output cs,
    input sdo,
    output sck,
    output hs,
    output vs,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );
    
wire clk_25;
//Not connecting these to anything cause I'm lazy. And it works.
wire reset;
wire locked;

// Divide clock from 100Mhz to 25MHz. We are using this for all lower level modules.
clk_wiz_0 clk_top
    (
    // Clock in ports
    .clk_in1(clk),      // input clk_in1
    // Clock out ports
    .clk_out1(clk_25),     // output clk_out1
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked));      // output locked

//Initialize three modules. 
//VGA should be always enabled. 
//Dec_counter module is on when switch[2] is 1 and vice versa for light_sensor.
vga_display vga (.switch(switch[1:0]), .clk(clk_25), .hs(hs), .vs(vs), .red(red), .green(green), .blue(blue));
dec_counter counter (.enable(switch[2]), .clk(clk_25), .led(led), .an(an));
light_sensor light (.enable(~switch[2]), .sdo(sdo), .clk(clk_25), .led(led), .an(an), .cs(cs), .sck(sck));

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nam Tran Ngoc
// Mailbox: 388
// 
// Create Date: 09/13/2016 01:59:32 PM
// Design Name: 
// Module Name: vga_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Outputs to VGA in three patterns, based on switch input
// 
// Dependencies: vga_controller_640_60
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_display(
    input [1:0] switch,
    input clk,
    output hs,
    output vs,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
);

// Define some set colors
parameter color_green   = 12'b0000_1111_0000;
parameter color_yellow  = 12'b1111_1111_0000;
parameter color_red     = 12'b1111_0000_0000;
parameter color_white   = 12'b1111_1111_1111;
parameter color_black   = 12'b0000_0000_0000;

wire [10:0] hcount;
wire [10:0] vcount;
wire [11:0] rgb; //Define a 12-bit rgb bus for colors
wire blank;
reg col; //Current collumn
reg [4:0] i;

//Instatiate VGA Controller
vga_controller_640_60 vga (.rst(reset), .pixel_clk(clk), .HS(hs), .VS(vs), .hcount(hcount), .vcount(vcount), .blank(blank));

//Stripes logic
always @ (hcount)
    // 800/32 = 25 
    for(i=0; i<25;i=i+1)
        begin    
            if (i%2)
                begin
                    if (hcount >= 32*i && hcount <= 32*i+31)
                        col <= 1'b1;
                end
            else
                begin
                    if (hcount >= 32*i && hcount <= 32*i+31)
                        col <= 1'b0;
                end
        end

// Square logic       
reg square;
always @ (hcount, vcount, square)
    if (hcount > 304 && hcount < 304+32 && 
        vcount > 224 && vcount < 224+16)
            square <= 1'b1;
    else
            square <= 1'b0;
   
wire [11:0] state_green; 
wire [11:0] state_alternate;
wire [11:0] state_square;

// Assign state colors;
assign state_green = (blank) ? color_black : color_green;
assign state_alternate = (blank) ? color_black : (col) ? color_yellow : color_red;
assign state_square = (blank) ? color_black : (square) ? color_white: color_black;

// Convert rgb to individual buses
assign rgb = (switch == 2'b00) ? state_green : (switch == 2'b01) ? state_alternate : state_square;
assign red = rgb[11:8];
assign green = rgb[7:4];
assign blue = rgb[3:0];

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2016 09:55:17 AM
// Design Name: 
// Module Name: lab1_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab1_top(
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [1:0] sel,
    input [1:0] sel_top,
    output [6:0] led,
    output [3:0] an
    );
    
    reg [3:0] a_top;
    reg [3:0] b_top;
    reg [3:0] c_top;
    reg [3:0] d_top;
    reg [7:0] left;
    reg [7:0] right;
    reg [8:0] sum;
    
    seven_seg seg1 (.a(a_top), .b(b_top), .c(c_top), .d(d_top), .sel(sel), .led(led), .an(an));
        
    always @ (sel_top, sel)
        case(sel_top)
            2'b00: 
                begin
                    a_top = a;
                    b_top = b;
                    c_top = c;
                    d_top = d;
                end
            2'b01:
                begin
                    b_top = 4'b0011;
                    c_top = 4'b1000;
                    d_top = 4'b1000;
                end
            2'b10:
                begin
                    a_top = 4'b1100;
                    b_top = 4'b1101;
                    c_top = 4'b1110;
                    d_top = 4'b1111;
                end
            2'b11:
                begin
                    left = {a, b};
                    right = {c, d};
                    sum = left + right;
                    
                    a_top = 4'b0;
                    b_top = {3'b0, sum[8]};
                    c_top = sum[7:4];
                    d_top = sum[3:0];
                end
        endcase
     
endmodule

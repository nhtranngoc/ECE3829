`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2016 07:01:09 PM
// Design Name: 
// Module Name: seven_seg
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


module seven_seg(
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [1:0] sel,
    output reg [6:0] led,
    output reg [3:0] an
    );
    
    reg [3:0] cnt;
    
    always @ (sel)
        case (sel)
            2'b00 : 
                begin
                    cnt = d;
                    an = 4'b1110;
                end
            2'b01 :
                begin
                    cnt = c;
                    an = 4'b1101;
                end
            2'b10:
                begin
                    cnt = b;
                    an = 4'b1011;
                end
            2'b11:
                begin
                    cnt = a;
                    an = 4'b0111;
                end
        endcase
        
    always @(*)
        case(cnt)
            4'h0 : led = 8'b11000000;
            4'h1 : led = 8'b11111001;
            4'h2 : led = 8'b10100100;
            4'h3 : led = 8'b10110000;
            4'h4 : led = 8'b10011001;
            4'h5 : led = 8'b10010010;
            4'h6 : led = 8'b10000010;
            4'h7 : led = 8'b11111000;
            4'h8 : led = 8'b10000000;
            4'h9 : led = 8'b10010000;
            4'hA : led = 8'b11001000;
            4'hB : led = 8'b10000011;
            4'hC : led = 8'b11000110;
            4'hD : led = 8'b10100001;
            4'hE : led = 8'b10000110;
            4'hF : led = 8'b10001110; 
            default : led = 8'b00000000;
        endcase
endmodule

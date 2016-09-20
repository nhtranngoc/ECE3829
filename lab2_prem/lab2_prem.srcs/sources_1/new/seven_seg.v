`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nam Tran Ngo
// Mailbox: 388
// 
// Create Date: 09/06/2016 12:58:45 AM
// Design Name: 
// Module Name: seven_seg
// Project Name: Multiple Seven Segment
// Target Devices: 
// Tool Versions: 
// Description: Multiple seven segment display using clock to cycle through all the digits. Output in Hexadecimal
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_seg(
    input enable,
    input [15:0] switch,
    input clk,
    output reg [6:0] led,
    output reg [3:0] an
    );

    //Clock speed at 100MHz - we only use the 2 MSB, which equals out to 100MHz/(2^17) ~= 762 Hz
    reg [18:0] counter;
    always @ (posedge clk)
        counter <= counter + 1;

    //Change anode pin and cnt input depending on counter value.
    reg [3:0] cnt;    
    always @ (switch, enable, counter)
        if (~enable)
            begin
                led <= 16'bz;
                an <= 4'bz;
            end
        else
        begin
        case (counter[18:17])
            2'b00: 
                begin
                    cnt = switch[3:0];
                    an = 4'b1110;                     
                end
            2'b01:
                begin
                    cnt = switch[7:4];
                    an = 4'b1101;
                end
            2'b10:
                begin  
                    cnt = switch[11:8];
                    an = 4'b1011;
                end
            2'b11:
                begin
                    cnt = switch[15:12];
                    an = 4'b0111;
                end
        endcase
        // Convert cnt to seven segment values.
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
                        4'hA : led = 8'b10001000;
                        4'hB : led = 8'b10000011;
                        4'hC : led = 8'b11000110;
                        4'hD : led = 8'b10100001;
                        4'hE : led = 8'b10000110;
                        4'hF : led = 8'b10001110; 
                        default : led = 8'b00000000;
                    endcase
        end
            
endmodule

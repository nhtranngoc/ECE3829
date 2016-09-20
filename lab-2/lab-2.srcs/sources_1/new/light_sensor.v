`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nam Tran Ngoc
// Mailbox 388 
// 
// Create Date: 09/14/2016 05:24:23 PM
// Design Name: 
// Module Name: light_sensor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Read SPI input from PmodALS module and pipe data out to seven segment display 
// 
// Dependencies: seven_seg
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module light_sensor(
    input enable, //Enable pin for switching between SPI output and decimal counter output
    input sdo,
    input clk,
    output [6:0] led,
    output [3:0] an,
    output reg cs,
    output sck
);
    
//25Mhz to 1Mhz clock counter
reg [4:0] counter_25;
always @ (posedge clk)
    if (counter_25 == 24)
        counter_25 <= 1'b0;
    else counter_25 <= counter_25 + 1'b1;
//sck operating at 1Mhz
assign sck = (counter_25 >= 12 && counter_25 < 24) ? 1 : 0;

//1Mhz to 10Hz counter
//cs is 0 for 16 sck cycles and 1 for the rest of the cycle
reg [16:0] counter_100k;
always @ (posedge sck)
    if (counter_100k <= 17'd16)
        begin
            counter_100k <= counter_100k + 1'b1;
            cs <= 1'b0;
        end
    else if (counter_100k >= 17'd99999)
        begin
            counter_100k <= 17'b0;
            cs <= 1'b1;
        end
    else 
        begin
            counter_100k <= counter_100k + 1'b1;
            cs <= 1'b1;
        end

// Using buffer as a shift register to shift data from sdo to a reg
reg [15:0] buffer;
wire [15:0] data;
always @ (posedge sck)
    if (~cs)
        begin
            buffer = buffer << 1;
            buffer[0] <= sdo;
        end
// Cut off parity bits, assign data to first 8 bit of seven segment input
assign data = {8'b0, buffer[11:4]};

seven_seg led_out (.enable(enable), .switch(data), .clk(clk), .led(led), .an(an));

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2016 09:10:01 AM
// Design Name: 
// Module Name: constant-value
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

module constant_value(
    input [7:0] switch,
    input clk,
    output reg sync,
    output reg d0,
    output sclk
);

wire reset;
wire locked;
wire clk_10M;

clk_wiz_0 clk_divider0
    (
    // Clock in ports
    .clk(clk),      // input clk
    // Clock out ports
    .clk_10M(clk_10M),     // output clk_10M
    // Status and control signals
    .reset(reset), // input reset
    .locked(locked));      // output locked
    
//Set output clock to 10MHz. Self-explanatory.
assign sclk = clk_10M; 

//Simple counter for sync signal
//Counts 100 cycles of 10MHz clock, effectively makes the period 100kHz
reg [6:0] counter_100;
always @ (posedge clk_10M)
    if (counter_100 <= 7'd16)
        begin
            counter_100 <= counter_100 + 1'b1;
            sync <= 1'b0;
        end
    else if (counter_100 >= 7'd99)
        begin
            counter_100 <= 7'b0;
            sync <= 1'b1;
        end
    else 
        begin
            counter_100 <= counter_100 + 1'b1;
            sync <= 1'b1;
        end

// Set control parameters. //Redundant department of redundancy.
parameter INT = 0;
parameter X = 0;
parameter LDAC = 0;
parameter [1:0] PD = 2'b10;
parameter AB = 0;
parameter [1:0] CR = 2'b0;
wire [7:0] control_bits;
assign control_bits = {INT, X, LDAC, PD, AB, CR};

//Set data bits
wire [7:0] data;
assign data = switch;


//Shift data out to D0
reg [15:0] buffer;
always @ (posedge sclk)
    if (~sync)
        begin
            d0 <= buffer[0];
            buffer = buffer >> 1;
        end
    else buffer <= {control_bits, data}; // This may not work out as expected. Just like my life. 
endmodule

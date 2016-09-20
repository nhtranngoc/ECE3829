`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nam Tran Ngoc
// Mailbox: 388 
// 
// Create Date: 09/11/2016 04:06:33 PM
// Design Name: 
// Module Name: dec_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Decimal counter from 0 to 99 using seven segment display 
// 
// Dependencies: seven_seg
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dec_counter(
    input enable,
    input switch,
    input clk,
    output [6:0] led,
    output [3:0] an
    );
    
    reg [22:0] counter;
    //Assign switch counter value
    reg [15:0] switch_cnt;
    
    always @ (posedge clk)
        begin
            //Further divide the clock down 
            if (counter == 23'd6250000)
                begin   
                    counter <= 23'd0;
                    // Since seven_seg outputs in hexadecimal, this convert output to decimal instead
                    if (switch_cnt[3:0] == 4'd9)
                        begin
                            // Reset on 99
                            if (switch_cnt[7:4] == 4'd9)
                                switch_cnt <= 16'd0;
                            else
                                begin
                                    switch_cnt[7:4] <= switch_cnt[7:4] + 1'd1;
                                    switch_cnt[3:0] <= 4'd0;
                                end
                        end
                    else
                        //Counting up
                        switch_cnt[3:0] <= switch_cnt[3:0] + 1'd1;
                end
            else 
                counter <= counter + 1'd1;
        end
        
    seven_seg s1 (.enable(enable), .switch(switch_cnt), .clk(clk), .led(led), .an(an));
    
endmodule

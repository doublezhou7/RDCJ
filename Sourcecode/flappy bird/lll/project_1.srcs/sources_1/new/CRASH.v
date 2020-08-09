`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 00:21:18
// Design Name: 
// Module Name: CRASH
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


module FAIL(
    input clk,
    input button1,
    input button2,
    input [11:0]HARD_X,
    input [11:0]HARD_Y,
    input [11:0]FB_X,
    input [11:0]FB_Y,
    output reg FAIL = 1'b0
    );
   // reg [29:0]counter;
    always@(posedge clk)
        begin
            if(HARD_X-FB_X<=45 && HARD_Y<FB_Y+55 &&HARD_Y>FB_Y-55)
                begin
                    //counter<=30'd0 ;  
                   FAIL<=1'b1;
                end
            if(!button1)
                begin
                   FAIL<=1'b0;
                end
                
            
        end
    
  //  always@(clk)
    //    begin
            //if(counter==30'd500000000) begin counter<=30'd0;CRASH<=1'b0;end
         //   else begin counter<=counter+1'd1; end
            
       // end
endmodule

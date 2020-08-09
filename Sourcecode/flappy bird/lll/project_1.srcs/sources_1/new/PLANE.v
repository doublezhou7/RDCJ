`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 12:55:19
// Design Name: 
// Module Name: PLANE
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


module FB(input key1,input key2,input clk,output [11:0]FB_x,output [11:0]FB_y);
    reg [11:0]FB_X=12'd200;
    reg [11:0]FB_Y=12'd360;
    
    always@(posedge clk)
        begin
            if(key1&&FB_Y>=10)  FB_Y<=FB_Y-5'd12;
            else if(key2&&FB_Y<=710) FB_Y<=FB_Y+5'd12;
            else  FB_Y<=FB_Y;
        end
    assign FB_x=FB_X;
    assign FB_y=FB_Y;
      
endmodule

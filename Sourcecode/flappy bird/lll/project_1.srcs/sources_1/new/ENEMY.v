`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 13:09:46
// Design Name: 
// Module Name: ENEMY
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


module HARD(input FAIL,input clk,input [9:0]randint,output [11:0]HARD_x,output [11:0]HARD_y);
    reg [11:0]HARD_X=12'd1180;
    reg [11:0]HARD_Y=12'd350;
    reg [31:0]count=0;
    reg moveflag=0;
    
    always@(posedge clk)
        begin
            if(!FAIL)
            begin
               if(count==32'd1000000) begin moveflag<=1'b1;count<=1'd0;  end
               else begin moveflag<=1'b0;count<=count+1'd1; end
            end
        end

    always@(posedge clk)
        begin
            if(moveflag)begin HARD_X<=HARD_X-1'd1; end
            else if(HARD_X<=30)begin HARD_X<=12'd1180;HARD_Y<=randint; end
            else if(FAIL)begin HARD_X<=12'd1180;end
            else begin HARD_X<=HARD_X; end
        end

assign HARD_x=HARD_X;
assign HARD_y=HARD_Y;

endmodule

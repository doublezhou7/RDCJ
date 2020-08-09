`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 11:27:47
// Design Name: 
// Module Name: HDMI_TOP
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


module HDMI_TOP(
    input clk_100MHz,
    input button1,
    input button2,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P
    );
    wire clk_system;
    wire [23:0]RGB_Data;
    wire [23:0]RGB_In;
    wire RGB_HSync;
    wire RGB_VSync;
    wire RGB_VDE;
    wire [11:0]Set_X;
    wire [11:0]Set_Y;
    wire [11:0]FB_x;
    wire [11:0]FB_y;
    wire [11:0]HARD_x;
    wire [11:0]HARD_y;
    wire key1,key2;
    wire [9:0]randint;
    wire FAIL;
    clk_wiz_0 clk_10(.clk_out1(clk_system),.clk_in1(clk_100MHz));
    //RGBToDvi instantiation
    rgb2dvi_0 rgb2dvi(
        .TMDS_Clk_p(TMDS_Tx_Clk_P),
        .TMDS_Clk_n(TMDS_Tx_Clk_N),
        .TMDS_Data_p(TMDS_Tx_Data_P),
        .TMDS_Data_n(TMDS_Tx_Data_N),
        .aRst_n(1),
        .vid_pData(RGB_Data),
        .vid_pVDE(RGB_VDE),
        .vid_pHSync(RGB_HSync),
        .vid_pVSync(RGB_VSync),
        .PixelClk(clk_system));
    //HDMI driver
    Driver_HDMI Driver_HDMI0(
        .clk(clk_system),        //Clock
        .Rst(1),                 //Reset signal, low reset
        .Video_Mode(1),          //Video format, 0 is 1920*1080@60Hz, 1 is 1280*720@60Hz
        .RGB_In(RGB_In),         //Input data
        .RGB_Data(RGB_Data),     //Output Data
        .RGB_HSync(RGB_HSync),   //Line signal
        .RGB_VSync(RGB_VSync),   //Field signal
        .RGB_VDE(RGB_VDE),       //Data valid signal
        .Set_X(Set_X),           //Image coordinate X
        .Set_Y(Set_Y)            //Image coordinate Y
        );

        
     // Bird bird0(.clk(clk_system),.key1(key1),.key2(key2),.PLANE_x(PLANE_x),.PLANE_y(PLANE_y)); 
     FB fb0(
          .clk(clk_system),
          .key1(key1),
          .key2(key2),
          .FB_x(FB_x),
          .FB_y(FB_y)
        );   
      FAIL fail0(
        .HARD_X(HARD_x),
        .HARD_Y(HARD_y),
        .FB_X(FB_x),
        .FB_Y(FB_y),
        .button1(button1),
        .button2(button2),        
        .clk(clk_system),
        .FAIL(FAIL)
        
        );    
      BUTTON button0(
          .clk(clk_system),
          .button1(button1),
          .button2(button2),
          .key1(key1),
          .key2(key2)
        );
      
      HARD hard0(
          .clk(clk_system),
          .FAIL(FAIL),
          .randint(randint),
          .HARD_x(HARD_x),
          .HARD_y(HARD_y)

        );

      random random0( 
        .HARD_Y(HARD_y),  
        .clk(clk_system),       
        .randint(randint)
    
        ); 

    Video_Generator Video_Generator0(
        .clk(clk_system),
        .FAIL(FAIL),
        .FB_x(FB_x),
        .FB_y(FB_y),
        .HARD_x(HARD_x),
        .HARD_y(HARD_y),
        .RGB_VDE(RGB_VDE),
        .Set_X(Set_X),
        .Set_Y(Set_Y),
        .RGB_Data(RGB_In)    //RBG
        );      
endmodule

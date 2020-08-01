`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 10:07:51
// Design Name: 
// Module Name: Top
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


module Top(
    input i_clk,
    input i_rst,
    input i_clk_rx_data_n,
    input i_clk_rx_data_p,
    input [1:0]i_rx_data_n,
    input [1:0]i_rx_data_p,
    input i_data_n,
    input i_data_p,
    inout i_camera_iic_sda,
    output o_camera_iic_scl,
    output o_camera_gpio,
    output TMDS_Tx_Clk_N,
    output TMDS_Tx_Clk_P,
    output [2:0]TMDS_Tx_Data_N,
    output [2:0]TMDS_Tx_Data_P
    );
    
    wire[23:0]rgb_data_src;//1
    wire [23:0]rgb_data;//2
    wire [10:0]set_x;//3
    wire [9:0]set_y;//4
    
    Camera_Demo Camera_1(
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_clk_rx_data_n(i_clk_rx_data_n),
    .i_clk_rx_data_p(i_clk_rx_data_p),
    .i_rx_data_n(i_rx_data_n),
    .i_rx_data_p(i_rx_data_p),
    .i_data_n(i_data_n),
    .i_data_p(i_data_p),
    .i_camera_iic_sda(i_camera_iic_sda),
    .o_camera_iic_scl(o_camera_iic_scl),
    .set_x(set_x),
    .set_y(set_y),
    .o_camera_gpio(o_camera_gpio),
    .rgb_data_src(rgb_data_src),
    .rgb_data(rgb_data)
    );
    
    Video_Generator Video_Generator_1(
    .set_x(set_x),
    .set_y(set_y),
    .rgb_data(rgb_data),
    .rgb_data_src(rgb_data_src)   
    );
    
endmodule

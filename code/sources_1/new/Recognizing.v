`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 11:23:26
// Design Name: 
// Module Name: Recognizing
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


module Recognizing(
    input rgb_vde,
    input data_bin,
    input [10:0]set_x,
    input [9:0]set_y,
    output reg [7:0]num_1 = 0,
    output reg [7:0]num_2 = 0,
    output reg [3:0]sym = 0
    );
    
    parameter X_test_1 = 440;
    parameter X_test_2 = 840;

    parameter Y_test_1 = 343;
    parameter Y_test_2 = 376;

     //判断交点
    reg [7:0] Y_check_1_1 = 8'hff;
    reg [7:0] Y_check_1_2 = 8'hff;
    reg [7:0] Y_check_1_3 = 8'hff;
    
    reg [7:0] Y_check_2_1 = 8'hff;
    reg [7:0] Y_check_2_2 = 8'hff;
    reg [7:0] Y_check_2_3 = 8'hff;
    
    reg [7:0] X_check_1 = 8'hff;
    reg [7:0] X_check_2 = 8'hff;
    
    //统计交点个数
    reg [1:0] cnt_y_1_1 = 0;
    reg [1:0] cnt_y_1_2 = 0;
    reg [1:0] cnt_y_1_3 = 0;
    
    reg [1:0] cnt_y_2_1 = 0;
    reg [1:0] cnt_y_2_2 = 0;
    reg [1:0] cnt_y_2_3 = 0;
    
    reg [1:0] cnt_x_1 = 0;
    reg [1:0] cnt_x_2 = 0;
    
   //分辨235
    reg [10:0] contrast_1 = 0; 
    reg [10:0] contrast_2 = 0;
    reg [10:0] contrast_3 = 0; 
    reg [10:0] contrast_4 = 0;
    
    reg a,b,c,d;//判断位置
    
    always@(set_x)
    begin
        if(rgb_vde)
            begin
                if(set_y == Y_test_1)
                    begin
                        if((set_x>=370)&&(set_x<=510))
                            begin
                                Y_check_1_1 ={Y_check_1_1[6:0],data_bin};
                                if(Y_check_1_1 == 8'hf0)
                                    begin
                                        cnt_y_1_1 = cnt_y_1_1 + 1;
                                        contrast_1 = set_x;//记录交点位置，便于分辨235
                                    end
                                else
                                    begin
                                        cnt_y_1_1 = cnt_y_1_1;
                                    end
                            end
                        else if((set_x>=570)&&(set_x<=710))
                            begin
                                Y_check_1_2 ={Y_check_1_2[6:0],data_bin};
                                if(Y_check_1_2 == 8'hf0)
                                    begin
                                        cnt_y_1_2 = cnt_y_1_2 + 1;
                                    end
                                else
                                    begin
                                        cnt_y_1_2 = cnt_y_1_2;
                                    end
                            end
                        else if((set_x>=770)&&(set_x<=910))
                            begin
                                Y_check_1_3 ={Y_check_1_3[6:0],data_bin};
                                if(Y_check_1_3 == 8'hf0)
                                    begin
                                        cnt_y_1_3 = cnt_y_1_3 + 1;
                                        contrast_2 = set_x;//记录交点位置，便于分辨235
                                    end
                                else
                                    begin
                                        cnt_y_1_3 = cnt_y_1_3;
                                    end
                            end
                        else
                            begin
                                Y_check_1_1 = 8'hff;
                                Y_check_1_2 = 8'hff;
                                Y_check_1_3 = 8'hff;
                            end      
                    end
                else if(set_y == Y_test_2)
                    begin
                        if((set_x>=370)&&(set_x<=510))
                            begin
                                Y_check_2_1 ={Y_check_2_1[6:0],data_bin};
                                if(Y_check_2_1 == 8'hf0)
                                    begin
                                        cnt_y_2_1 = cnt_y_2_1 + 1;
                                        contrast_3 = set_x;//记录交点位置，便于分辨235
                                    end
                                else
                                    begin
                                        cnt_y_2_1 = cnt_y_2_1;
                                    end
                            end
                        else if((set_x>=570)&&(set_x<=710))
                            begin
                                Y_check_2_2 <={Y_check_2_2[6:0],data_bin};
                                if(Y_check_2_2 == 8'hf0)
                                    begin
                                        cnt_y_2_2 = cnt_y_2_2 + 1;
                                    end
                                else
                                    begin
                                        cnt_y_2_2 = cnt_y_2_2;
                                    end
                            end
                        else if((set_x>=770)&&(set_x<=910))
                            begin
                                Y_check_2_3 ={Y_check_2_3[6:0],data_bin};
                                if(Y_check_2_3 == 8'hf0)
                                    begin
                                        cnt_y_2_3 = cnt_y_2_3 + 1;
                                        contrast_4 = set_x;//记录交点位置，便于分辨235
                                    end
                                else
                                    begin
                                        cnt_y_2_3 = cnt_y_2_3;
                                    end
                            end
                        else
                            begin
                                Y_check_2_1 = 8'hff;
                                Y_check_2_2 = 8'hff;
                                Y_check_2_3 = 8'hff;
                            end      
                    end
                else if((set_y>=290)&&(set_y<=430))
                    begin
                        if(set_x == X_test_1)
                            begin
                                X_check_1 ={X_check_1[6:0],data_bin};
                                if(X_check_1 == 8'hf0)
                                    begin
                                        cnt_x_1 = cnt_x_1 + 1;
                                    end
                                else
                                    begin
                                        cnt_x_1 = cnt_x_1;
                                    end
                            end
                        else if(set_x == X_test_2)
                            begin
                                X_check_2 ={X_check_2[6:0],data_bin};
                                if(X_check_2 == 8'hf0)
                                    begin
                                        cnt_x_2 = cnt_x_2 + 1;
                                    end
                                else
                                    begin
                                        cnt_x_2 = cnt_x_2;
                                    end
                            end
                        else
                            begin
                                 cnt_x_1 = cnt_x_1;
                                 cnt_x_2 = cnt_x_2;
                            end
                    end
                else if((set_y == 500)&&(set_x == 500))
                    begin
                        sym = {cnt_y_1_2,cnt_y_2_2};
                        if(contrast_1 >= X_test_1)//判断235 的交点关系
                            begin
                                a = 1;
                            end
                        else
                            begin
                                a = 0;
                            end
                        if(contrast_2 >= X_test_2)
                            begin
                                b = 1;
                            end
                        else
                            begin
                                b = 0;
                            end
                        if(contrast_3 >= X_test_1)
                            begin
                                c = 1;
                            end
                        else
                            begin
                                c = 0;
                            end
                        if(contrast_4 >= X_test_2)
                            begin
                                d = 1;
                            end
                        else
                            begin
                                d = 0;
                            end
                            
                        num_1 = {cnt_y_1_1,cnt_y_2_1,cnt_x_1,a,c};//判断依据为交点数和交点位置
                        num_2 = {cnt_y_1_2,cnt_y_2_2,cnt_x_2,b,d};//判断依据为交点数和交点位置
                        X_check_1 = 8'hff;//重置
                        X_check_2 = 8'hff;
                        cnt_y_1_1 = 0;
                        cnt_y_1_2 = 0;
                        cnt_y_1_3 = 0;
                        cnt_y_2_1 = 0;
                        cnt_y_2_2 = 0;
                        cnt_y_2_3 = 0;
                        cnt_x_1 = 0;
                        cnt_x_2 = 0;
                    end
            end
    end
endmodule







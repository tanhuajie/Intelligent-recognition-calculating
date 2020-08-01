`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 09:16:30
// Design Name: 
// Module Name: Video_Generator
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


module Video_Generator(
    input [23:0]rgb_data,
    input [10:0]set_x,
    input [9:0]set_y,
    input [7:0]R_Data,
    output reg [23:0]rgb_data_src,
    output reg ena_a,
    output reg ena_b,
    output reg [9:0]address
    );
    
    parameter up_side = 310;
    parameter down_side = 410;
    parameter side_1 = 390;
    parameter side_2 = 490;
    parameter side_3 = 590;
    parameter side_4 = 690;
    parameter side_5 = 790;
    parameter side_6 = 890;
    
    
    always@(*)
    begin
        if((set_y == up_side)||(set_y == down_side))
            begin
                if((set_x>=side_1)&&(set_x<=side_2))
                    begin
                        rgb_data_src = 24'hff0000;
                    end
                else if((set_x>=side_3)&&(set_x<=side_4))
                    begin
                        rgb_data_src = 24'hff0000;
                    end
                else if((set_x>=side_5)&&(set_x<=side_6))
                    begin
                        rgb_data_src = 24'hff0000;
                    end
                else
                    begin
                        rgb_data_src = rgb_data;
                    end
            end
        else if((set_y>up_side)&&(set_y<down_side))
            begin
                if((set_x == side_1)||(set_x == side_2)||(set_x == side_3)||(set_x == side_4)||(set_x == side_5)||(set_x == side_6))
                    begin
                        rgb_data_src = 24'hff0000;
                    end
                else
                    begin
                        rgb_data_src = rgb_data;
                    end
            end
        else if((set_y>=530)&&(set_y<560))
            begin
                if((set_x>=590)&&(set_x<620))
                    begin
                        ena_a = 1;
                        address = (set_x - 589)*30 + (set_y - 529);
                        rgb_data_src = {R_Data,R_Data,R_Data};
                    end
                else if((set_x>=660)&&(set_x<690))
                    begin
                        ena_b = 1;
                        address = (set_x - 659)*30 + (set_y - 529);
                        rgb_data_src = {R_Data,R_Data,R_Data};
                    end
                else 
                    begin
                        ena_a = 0;
                        ena_b = 0;
                        rgb_data_src = rgb_data;
                    end
            end
        else
            begin
                 rgb_data_src = rgb_data;
            end
    end 
endmodule





`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 10:57:17
// Design Name: 
// Module Name: Processing
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


module Processing(
    input [23:0]rgb_data,
    output reg data_bin 
    );
    
    wire[7:0]RGB_Data_R;              //�������� R 
    wire [7:0]RGB_Data_G;             //�������� G 
    wire [7:0]RGB_Data_B;             //�������� B
    reg [7:0]Gray_Data;               //�ݴ�Ҷ����� 
    reg [32:0]Out_Data = 0; 

    parameter YUZHI = 50;

    assign RGB_Data_R = rgb_data[23:16];
    assign RGB_Data_G = rgb_data[15:8];
    assign RGB_Data_B = rgb_data[7:0];
    
    always@(*)
    begin
        Out_Data=(RGB_Data_R*30+RGB_Data_B*11+RGB_Data_G*59+50)/100;//�ҶȻ�
        Gray_Data = Out_Data[7:0];
        if(Gray_Data>=YUZHI)//��ֵ��
            begin
                data_bin = 1;
            end    
        else
            begin
                data_bin = 0;
            end    
    end
endmodule










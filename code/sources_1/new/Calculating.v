`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 13:47:18
// Design Name: 
// Module Name: Calculating
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


module Calculating(
    input [3:0]shape_1,
    input [3:0]shape_2,
    input [1:0]shape_sym,
    output reg [3:0]result_1,
    output reg [3:0]result_2
    );
    
    reg [6:0]result = 0;
    reg [3:0]check_1 = 0;
    reg [6:0]check_2 = 0;
    
    always@(*)
    begin
        case(shape_sym)
            2'b01: result = shape_1 + shape_2;
            2'b10: result = shape_1 - shape_2;
            2'b11: result = shape_1 * shape_2;
            default: result = 0;
        endcase
        check_2 = result;
        if(check_2[6:3] >= 4'b1010)//1
            begin
                check_1 = {check_1[2:0],1'b1};
                check_2 = check_2 - 7'b1010000; 
            end
        else
            begin
                check_1 = {check_1[2:0],1'b0};
            end
        if(check_2[5:2] >= 4'b1010)//2
            begin
                check_1 = {check_1[2:0],1'b1};
                check_2 = check_2 - 7'b0101000; 
            end
        else
            begin
                check_1 = {check_1[2:0],1'b0};
            end
        if(check_2[4:1] >= 4'b1010)//3
            begin
                check_1 = {check_1[2:0],1'b1};
                check_2 = check_2 - 7'b0010100; 
            end
        else
            begin
                check_1 = {check_1[2:0],1'b0};
            end
        if(check_2[3:0] >= 4'b1010)//4
            begin
                check_1 = {check_1[2:0],1'b1};
                check_2 = check_2 - 7'b0001010; 
            end
        else
            begin
                check_1 = {check_1[2:0],1'b0};
            end
        result_1 = check_1;
        result_2 = check_2[3:0];
    end
    
    
endmodule








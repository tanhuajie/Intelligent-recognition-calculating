`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 13:16:16
// Design Name: 
// Module Name: Judging
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


module Judging(
    input [7:0]num_1,
    input [7:0]num_2,
    input [3:0]sym,
    output reg [3:0]shape_1,
    output reg [3:0]shape_2,
    output reg [1:0]shape_sym
    );
    
    wire [5:0] point_1_1 = {num_1[7:2]};
    wire [1:0] point_1_2 = {num_1[1:0]};
    wire [5:0] point_2_1 = {num_2[7:2]};
    wire [1:0] point_2_2 = {num_2[1:0]};
    
    always@(*)
    begin
        case(point_1_1)
                        9'b10_10_10: shape_1 = 4'd0;
                        9'b01_01_01: shape_1 = 4'd1;
                        9'b10_01_10: shape_1 = 4'd4; 
                        9'b01_10_11: shape_1 = 4'd6;
                        9'b01_01_10: shape_1 = 4'd7;
                        9'b10_10_11: shape_1 = 4'd8; 
                        9'b10_01_11: shape_1 = 4'd9;
                        9'b01_01_11: case(point_1_2)
                                                2'b10: shape_1 = 4'd2;
                                                2'b01: shape_1 = 4'd5;
                                                2'b11: shape_1 = 4'd3;
                                                default: shape_1 = 4'd0;
                                     endcase
                       default: shape_1 = 4'd0;
        endcase
        case(point_2_1)
                        9'b10_10_10: shape_2 = 4'd0;
                        9'b01_01_01: shape_2 = 4'd1;
                        9'b10_01_10: shape_2 = 4'd4; 
                        9'b01_10_11: shape_2 = 4'd6;
                        9'b01_01_10: shape_2 = 4'd7;
                        9'b10_10_11: shape_2 = 4'd8; 
                        9'b10_01_11: shape_2 = 4'd9;
                        9'b01_01_11: case(point_2_2)
                                                2'b10: shape_2 = 4'd2;
                                                2'b01: shape_2 = 4'd5;
                                                2'b11: shape_2 = 4'd3;
                                                default: shape_2 = 4'd0;
                                     endcase
                       default: shape_2 = 4'd0;
        endcase
        case(sym)
                    4'b1010: shape_sym = 2'b11;
                    4'b0101: shape_sym = 2'b01;
                    4'b0000: shape_sym = 2'b10;
                    default: shape_sym = 2'b00;
        endcase
                         
    end


endmodule

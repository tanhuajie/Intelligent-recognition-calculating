`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/01 15:04:51
// Design Name: 
// Module Name: Rom
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


module Rom(
    input clk,
    input ena_a,
    input ena_b,
    input [3:0]result_1,
    input [3:0]result_2,
    input [9:0]address,
    output reg [7:0]R_Data
    );

    wire ena_0 = (((ena_a == 1)&&(result_1 == 4'd0))||((ena_b == 1)&&(result_2 == 4'd0)))? 1:0;
    wire ena_1 = (((ena_a == 1)&&(result_1 == 4'd1))||((ena_b == 1)&&(result_2 == 4'd1)))? 1:0;
    wire ena_2 = (((ena_a == 1)&&(result_1 == 4'd2))||((ena_b == 1)&&(result_2 == 4'd2)))? 1:0;
    wire ena_3 = (((ena_a == 1)&&(result_1 == 4'd3))||((ena_b == 1)&&(result_2 == 4'd3)))? 1:0;
    wire ena_4 = (((ena_a == 1)&&(result_1 == 4'd4))||((ena_b == 1)&&(result_2 == 4'd4)))? 1:0;
    wire ena_5 = (((ena_a == 1)&&(result_1 == 4'd5))||((ena_b == 1)&&(result_2 == 4'd5)))? 1:0;
    wire ena_6 = (((ena_a == 1)&&(result_1 == 4'd6))||((ena_b == 1)&&(result_2 == 4'd6)))? 1:0;
    wire ena_7 = (((ena_a == 1)&&(result_1 == 4'd7))||((ena_b == 1)&&(result_2 == 4'd7)))? 1:0;
    wire ena_8 = (((ena_a == 1)&&(result_1 == 4'd8))||((ena_b == 1)&&(result_2 == 4'd8)))? 1:0;
    wire ena_9 = (((ena_a == 1)&&(result_1 == 4'd9))||((ena_b == 1)&&(result_2 == 4'd9)))? 1:0;
    
    wire [7:0]Data_0;
    wire [7:0]Data_1;
    wire [7:0]Data_2; 
    wire [7:0]Data_3;
    wire [7:0]Data_4; 
    wire [7:0]Data_5;
    wire [7:0]Data_6; 
    wire [7:0]Data_7;
    wire [7:0]Data_8; 
    wire [7:0]Data_9;
    

 //用于判断Address的输入端   
    wire [9:0] Addr_Out_0 = (ena_0)? address : 0;
    wire [9:0] Addr_Out_1 = (ena_1)? address : 0;
    wire [9:0] Addr_Out_2 = (ena_2)? address : 0;
    wire [9:0] Addr_Out_3 = (ena_3)? address : 0;
    wire [9:0] Addr_Out_4 = (ena_4)? address : 0;
    wire [9:0] Addr_Out_5 = (ena_5)? address : 0;
    wire [9:0] Addr_Out_6 = (ena_6)? address : 0;
    wire [9:0] Addr_Out_7 = (ena_7)? address : 0;
    wire [9:0] Addr_Out_8 = (ena_8)? address : 0;
    wire [9:0] Addr_Out_9 = (ena_9)? address : 0;

 //输出mode，用于判断 R_data的接收端 
    wire [9:0] mode = {ena_0,ena_1,ena_2,ena_3,ena_4,ena_5,ena_6,ena_7,ena_8,ena_9};
    
//用于判断输出端
    always@(clk)
    begin
        case(mode)
            10'b100_000_000_0: R_Data = Data_0;
            10'b010_000_000_0: R_Data = Data_1;
            10'b001_000_000_0: R_Data = Data_2;
            10'b000_100_000_0: R_Data = Data_3;
            10'b000_010_000_0: R_Data = Data_4;
            10'b000_001_000_0: R_Data = Data_5;
            10'b000_000_100_0: R_Data = Data_6;
            10'b000_000_010_0: R_Data = Data_7;
            10'b000_000_001_0: R_Data = Data_8;
            10'b000_000_000_1: R_Data = Data_9;
            default: R_Data = R_Data;
        endcase
    end
    
     ROM_0 u0 (        
        .clka(clk),                          
        .ena(ena_0),    
        .addra(Addr_Out_0),                  
        .douta(Data_0)          
        );
        
     ROM_1 u1 (        
        .clka(clk),                          
        .ena(ena_1),    
        .addra(Addr_Out_1),                  
        .douta(Data_1)          
        );
        
     ROM_2 u2 (        
        .clka(clk),                          
        .ena(ena_2),    
        .addra(Addr_Out_2),                  
        .douta(Data_2)          
        );
        
     ROM_3 u3 (        
        .clka(clk),                          
        .ena(ena_3),    
        .addra(Addr_Out_3),                  
        .douta(Data_3)          
        );
        
     ROM_4 u4 (        
        .clka(clk),                          
        .ena(ena_4),    
        .addra(Addr_Out_4),                  
        .douta(Data_4)          
        );
        
     ROM_5 u5 (        
        .clka(clk),                          
        .ena(ena_5),    
        .addra(Addr_Out_5),                  
        .douta(Data_5)          
        );
        
     ROM_6 u6 (        
        .clka(clk),                          
        .ena(ena_6),    
        .addra(Addr_Out_6),                  
        .douta(Data_6)          
        );
        
     ROM_7 u7 (        
        .clka(clk),                          
        .ena(ena_7),    
        .addra(Addr_Out_7),                  
        .douta(Data_7)          
        );
        
     ROM_8 u8 (        
        .clka(clk),                          
        .ena(ena_8),    
        .addra(Addr_Out_8),                  
        .douta(Data_8)          
        );
        
     ROM_9 u9 (        
        .clka(clk),                          
        .ena(ena_9),    
        .addra(Addr_Out_9),                  
        .douta(Data_9)          
        );
endmodule

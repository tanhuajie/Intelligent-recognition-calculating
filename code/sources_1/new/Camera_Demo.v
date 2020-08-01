`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/25 09:56:56
// Design Name: 
// Module Name: Camera_Demo
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


module Camera_Demo(
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
    //ʱ���ź�
    wire clk_100MHz_system;
    wire clk_200MHz;
    
    //HDMI�ź�
    wire rgb_hsync_src;
    wire rgb_vsync_src;
    wire rgb_vde;
    wire rgb_vde_src = rgb_vde;
    wire clk_pixel;
    wire clk_serial;
    
    wire[23:0]rgb_data_src;//1
    wire [23:0]rgb_data;//2
    wire data_bin;
    wire [10:0]set_x;//3
    wire [9:0]set_y;//4
    
    wire [7:0]num_1;
    wire [7:0]num_2;
    wire [3:0]sym;
    wire [3:0]shape_1;//��һ����
    wire [3:0]shape_2;//�ڶ�����
    wire [1:0]shape_sym;//����
    
    wire ena_a;
    wire ena_b;
    wire [9:0]address;
    wire [7:0]R_Data;
    wire [3:0]result_1;
    wire [3:0]result_2;
    
    wire clk; 
    
    Video_Generator Video_Generator_1(
    .set_x(set_x),
    .set_y(set_y),
    .rgb_data(rgb_data),
    .rgb_data_src(rgb_data_src),
    .ena_a(ena_a),
    .ena_b(ena_b),
    .address(address),
    .R_Data(R_Data)   
    );
    
    Rom Rom_1(
    .ena_a(ena_a),
    .ena_b(ena_b),
    .address(address),
    .R_Data(R_Data),
    .result_1(result_1),
    .result_2(result_2),
    .clk(clk)
    );
    
    Processing Processing_1(
    .rgb_data(rgb_data),
    .data_bin(data_bin)
    );
    
    Recognizing Recognizing_1(
    .rgb_vde(rgb_vde),
    .set_x(set_x),
    .set_y(set_y),
    .data_bin(data_bin),
    .num_1(num_1),
    .num_2(num_2),
    .sym(sym)
    );
    
    Judging Judging_1(
    .num_1(num_1),
    .num_2(num_2),
    .sym(sym),
    .shape_1(shape_1),
    .shape_2(shape_2),
    .shape_sym(shape_sym)
    );
    
    Calculating Calculating_1(
    .shape_1(shape_1),
    .shape_2(shape_2),
    .shape_sym(shape_sym),
    .result_1(result_1),
    .result_2(result_2)
    );
    
    //ϵͳʱ��
    clk_wiz_0 clk_10(.clk_out1(clk_100MHz_system),.clk_out2(clk_200MHz),.clk_out3(clk),.clk_in1(i_clk));
    
    //HDMI����
    rgb2dvi_0 Mini_HDMI_Driver(
      .TMDS_Clk_p(TMDS_Tx_Clk_P),     // output wire TMDS_Clk_p
      .TMDS_Clk_n(TMDS_Tx_Clk_N),     // output wire TMDS_Clk_n
      .TMDS_Data_p(TMDS_Tx_Data_P),      // output wire [2 : 0] TMDS_Data_p
      .TMDS_Data_n(TMDS_Tx_Data_N),      // output wire [2 : 0] TMDS_Data_n
      .aRst_n(i_rst),                   // input wire aRst_n
      .vid_pData(rgb_data_src),         // input wire [23 : 0] vid_pData
      .vid_pVDE(rgb_vde_src),           // input wire vid_pVDE
      .vid_pHSync(rgb_hsync_src),       // input wire vid_pHSync
      .vid_pVSync(rgb_vsync_src),       // input wire vid_pVSync
      .PixelClk(clk_pixel)
    );
    
    //ͼ��MIPI�ź�תRGB
    Driver_MIPI MIPI_Trans_Driver(
        .i_clk_200MHz(clk_200MHz),
        .i_clk_rx_data_n(i_clk_rx_data_n),
        .i_clk_rx_data_p(i_clk_rx_data_p),
        .i_rx_data_n(i_rx_data_n),
        .i_rx_data_p(i_rx_data_p),
        .i_data_n(i_data_n),
        .i_data_p(i_data_p),
        .o_camera_gpio(o_camera_gpio),
        .o_rgb_data(rgb_data),
        .o_rgb_hsync(rgb_hsync_src),
        .o_rgb_vsync(rgb_vsync_src),
        .o_rgb_vde(rgb_vde),
        .o_set_x(set_x),
        .o_set_y(set_y),
        .o_clk_pixel(clk_pixel)
    );
    
    //����ͷIIC��SDA�ߵ���̬�ڵ�
    wire camera_iic_sda_i;
    wire camera_iic_sda_o;
    wire camera_iic_sda_t;
    
    //Tri-state gate
    IOBUF Camera_IIC_SDA_IOBUF
       (.I(camera_iic_sda_o),
        .IO(i_camera_iic_sda),
        .O(camera_iic_sda_i),
        .T(~camera_iic_sda_t));
    
    //����ͷIIC�����ź�
    wire iic_busy;
    wire iic_mode;
    wire [7:0]slave_addr;
    wire [7:0]reg_addr_h;
    wire [7:0]reg_addr_l;
    wire [7:0]data_w;
    wire [7:0]data_r;
    wire iic_write;
    wire iic_read;
    wire ov5647_ack;
    
    //����ͷ����
    OV5647_Init MIPI_Camera_Driver(
        .i_clk(clk_100MHz_system),
        .i_rst(i_rst),
        .i_iic_busy(iic_busy),
        .o_iic_mode(iic_mode),          
        .o_slave_addr(slave_addr),    
        .o_reg_addr_h(reg_addr_h),   
        .o_reg_addr_l(reg_addr_l),   
        .o_data_w(data_w),      
        .o_iic_write(iic_write),
        .o_ack(ov5647_ack)                 
    );
    
    //����ͷIIC����
    Driver_IIC MIPI_Camera_IIC(
        .i_clk(clk_100MHz_system),
        .i_rst(i_rst),
        .i_iic_sda(camera_iic_sda_i),
        .i_iic_write(iic_write),                //IICд�ź�,��������Ч
        .i_iic_read(iic_read),                  //IIC���ź�,��������Ч
        .i_iic_mode(iic_mode),                  //IICģʽ,1����˫��ַλ,0������ַλ,��λ��ַ��Ч
        .i_slave_addr(slave_addr),              //IIC�ӻ���ַ
        .i_reg_addr_h(reg_addr_h),              //�Ĵ�����ַ,��8λ
        .i_reg_addr_l(reg_addr_l),              //�Ĵ�����ַ,��8λ
        .i_data_w(data_w),                      //��Ҫ���������
        .o_data_r(data_r),                      //IIC����������
        .o_iic_busy(iic_busy),                  //IICæ�ź�,�ڹ���ʱæ,�͵�ƽæ
        .o_iic_scl(o_camera_iic_scl),           //IICʱ����
        .o_sda_dir(camera_iic_sda_t),           //IIC�����߷���,1�������
        .o_iic_sda(camera_iic_sda_o)            //IIC������
    );
    
endmodule

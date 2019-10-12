`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/01 15:46:47
// Design Name: 
// Module Name: spi_control
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


module spi_control(
        clk,
        I_rst_n,
        I_tx_en,
        spi_x_out,
        spi_y_out,
        I_spi_miso,
        O_spi_sck,
        O_spi_cs,
        O_spi_mosi
    );
    input clk;
    output reg [3:0]spi_x_out;
    output reg[3:0]spi_y_out;
    input  I_rst_n; // 复位信号，低电平有效
    input  I_tx_en; // 发送使能信号
    
    input    I_spi_miso; // SPI串行输入，用来接收从机的数据
    output  wire         O_spi_sck; // SPI时钟
    output  wire         O_spi_cs  ; // SPI片选信号
    output  wire         O_spi_mosi ;   // SPI输出，用来给从机发送数据    
    wire [7:0]spi_data_out;
    reg [15:0]spi_data_in;
    
    spi_module spi(
        .I_clk(clk),
        .I_rst_n(I_rst_n), // 复位信号，低电平有效
        .I_tx_en(I_tx_en), // 发送使能信号
        .I_data_in(spi_data_in), // 要发送的数据
        .O_data_out(spi_data_out), // 接收到的数据
        
        // 四线标准SPI信号定义
       .I_spi_miso(I_spi_miso) , // SPI串行输入，用来接收从机的数据
       .O_spi_sck(O_spi_sck)   , // SPI时钟
       .O_spi_cs(O_spi_cs)    , // SPI片选信号
       .O_spi_mosi(O_spi_mosi)   // SPI输出，用来给从机发送数据          
    );
    
    integer i=0;
    always@(posedge clk)
    begin
        i=i+1;
        if(i==1)
        begin
            spi_data_in<=16'b0000_1011_0000_1111;
        end
        else if(i==100)
        begin
             spi_y_out<=spi_data_out[3:0];
        end
        
        else if(i==101)
        begin
            spi_data_in<=16'b0000_1011_0001_0001;
        end
        else if(i==200)
        begin
             spi_x_out<=spi_data_out[3:0];
             i=0;
        end
    end
endmodule

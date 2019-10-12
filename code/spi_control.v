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
    input  I_rst_n; // ��λ�źţ��͵�ƽ��Ч
    input  I_tx_en; // ����ʹ���ź�
    
    input    I_spi_miso; // SPI�������룬�������մӻ�������
    output  wire         O_spi_sck; // SPIʱ��
    output  wire         O_spi_cs  ; // SPIƬѡ�ź�
    output  wire         O_spi_mosi ;   // SPI������������ӻ���������    
    wire [7:0]spi_data_out;
    reg [15:0]spi_data_in;
    
    spi_module spi(
        .I_clk(clk),
        .I_rst_n(I_rst_n), // ��λ�źţ��͵�ƽ��Ч
        .I_tx_en(I_tx_en), // ����ʹ���ź�
        .I_data_in(spi_data_in), // Ҫ���͵�����
        .O_data_out(spi_data_out), // ���յ�������
        
        // ���߱�׼SPI�źŶ���
       .I_spi_miso(I_spi_miso) , // SPI�������룬�������մӻ�������
       .O_spi_sck(O_spi_sck)   , // SPIʱ��
       .O_spi_cs(O_spi_cs)    , // SPIƬѡ�ź�
       .O_spi_mosi(O_spi_mosi)   // SPI������������ӻ���������          
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

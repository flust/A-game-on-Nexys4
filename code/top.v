`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 08:51:30
// Design Name: 
// Module Name: top
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


module top_logic(  
		clk,
		rst,
		frz,
		level,
		Dout,
		vsync,
		hsync,
		VGA_R,
		VGA_G,
		VGA_B,
		BTNU,
		BTND,
		BTNL,
		BTNR,
        seven_seg,
        sel,
        pattern_select,
         I_spi_miso,
         O_spi_sck,
         O_spi_cs,
         O_spi_mosi
);
	input clk;
    input rst;
    input frz;
    input [4:0]level;//游戏难度
    input Dout;//声音传感器
    output vsync;
    output hsync;
    output [3:0] VGA_R;
    output [3:0] VGA_G;
    output [3:0] VGA_B;
    input BTNU;
    input BTND;
    input BTNR;
    input BTNL;
    output [7:0]seven_seg;
    output [7:0] sel;
    
    wire left;
    wire right;
    wire up;
    wire down;
    assign left=BTNL;
    assign right=BTNR;
    assign up=BTNU;
    assign down=BTND;
    
    
    
    input    I_spi_miso; // SPI串行输入，用来接收从机的数据
    output  wire         O_spi_sck; // SPI时钟
    output  wire         O_spi_cs  ; // SPI片选信号
    output  wire         O_spi_mosi ;   // SPI输出，用来给从机发送数据       
    input pattern_select;
    
    wire [3:0]spi_x_out;
    wire [3:0]spi_y_out;
    wire [15:0]score;
   spi_control spi(
                .clk(clk),
                .I_rst_n(!rst),
                .I_tx_en(1),
                .spi_x_out(spi_x_out),
                .spi_y_out(spi_y_out),
                .I_spi_miso(I_spi_miso),
                .O_spi_sck(O_spi_sck),
                .O_spi_cs(O_spi_cs),
                .O_spi_mosi(O_spi_mosi)
    );
    vga VGA( 
			 .clk(clk),
			 .rst(rst),
			 .frz(~frz),
			 .color_change(Dout),
			 .score2(score),
			 .vsync(vsync),
			 .hsync(hsync),
			 .VGA_R(VGA_R),
			 .VGA_G(VGA_G),
			 .VGA_B(VGA_B),
			 .up(up),
			 .down(down),
			 .right(right),
			 .left(left),
			 .pattern_select(pattern_select),
			 .over(over),
			 .spi_x_out(spi_x_out),
			 .spi_y_out(spi_y_out)
	);

    seg_display seg(
            .clk(clk),
            .seven_seg(seven_seg),
            .sel(sel),
            .over(over),
            .idata(score)
    );
    
        
endmodule

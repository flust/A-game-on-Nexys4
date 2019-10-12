`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 10:13:47
// Design Name: 
// Module Name: vga
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


module vga(
        clk, 
		rst,
		frz,
		color_change,
		score2,
		vsync,
		hsync,
		VGA_R,
		VGA_G,
		VGA_B,
		up,
		down,
		right,
		left,
		pattern_select,
		over,
		spi_x_out,
		spi_y_out
    );
    input clk; 
    input rst;
    input frz;
    input color_change;
    output vsync;
    output hsync;
    output [3:0] VGA_R;
    output [3:0] VGA_G;
    output [3:0] VGA_B;
    input up;
    input down;
    input right;
    input left;
    
    wire [15:0]score;
    output wire [15:0]score2;
    
    input pattern_select;
    input [3:0]spi_x_out;
    input [3:0]spi_y_out;
    
    
    
    //第一个子弹的轨迹
    wire [11:0]pixel;
    wire [10:0] bullet1_x;
    wire [9:0] bullet1_y;
    wire[11:0]bullet1_pixel;
  //  wire win_rst1;
    
    //第二个子弹的轨迹
    wire [10:0] bullet2_x;
    wire [9:0] bullet2_y;
    wire[11:0]bullet2_pixel;
    //玩家位置
    wire [10:0]player_x;
    wire  [9:0]player_y;
    wire[11:0]player_pixel;
    wire [11:0]board_pixel;
    
    output wire over;
    
    
    
    //================================VGA
    reg	 vs;
    reg hs;
    reg [10:0] hcount;
    reg [9:0] vcount;
    reg [9:0] counter;
    reg frame;
    wire hsyncon;
    wire hsyncoff;
    wire hreset;
    wire vclk;
    // horizontal: 1039 pixels total
    // display 800 pixels per line
    assign hsyncon = (hcount == 855);
    assign hsyncoff = (hcount == 975);
    assign hreset = (hcount == 1039);

    // vertical: 665 lines total
    // display 600 lines
    wire vsyncon,vsyncoff,vreset;
    assign vsyncon = hreset & (vcount == 636);
    assign vsyncoff = hreset & (vcount == 642);
    assign vreset = hreset & (vcount == 665);

    // Get 50Mhz clock for the vga calculations
    ClkDiv_50MHz vgaclk(
         .CLK(clk),
         .RST(rst),
         .CLKOUT(vclk)
    );
  
    always @(posedge clk) 
    begin
        if (rst == 1)  
        begin
            hcount <= 0;
            vcount <= 0;
            vs <= 1;
            hs <= 1;
            counter <= 0;
            frame <= 0;
        end
        else 
        begin
            if ( vclk == 1 ) 
            begin
                hcount <= hreset ? 0 : hcount + 1;//判断hcount+1的条件
                hs <= hsyncon ? 0 : hsyncoff ? 1 : hs;  // active low
                vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;//判断vcount+1的条件
                vs <= vsyncon ? 0 : vsyncoff ? 1 : vs;  // active low
                
                if ( vs == 0 )
                    counter <= counter + 1;
                    
                if ( counter ==  900 &&  frz == 0)   //控制速度，由vs计数决定
                begin
                    counter <= 0;
                    frame <= 1;
                end
                else
                    frame <= 0;
            end
        end
    end
//=============================================================
    
    
    
    
    //===========================draw=======================
   
    draw_bullet1 bullet1(
        .clk(vclk),
        .hcount(hcount),
        .vcount(vcount),
        .x(bullet1_x),
        .y(bullet1_y),
        .pixel(bullet1_pixel)
    );

    bullet_move movebullet1(
         .frame(frame),
         .clk(vclk),
         .rst(rst),
         .score(score2),
         .x(bullet1_x),
         .y(bullet1_y),
         .over(over)
 //        .win_rst(win_rst1)
    );
    
     
    draw_bullet2 bullet2(
        .clk(vclk),
        .hcount(hcount),
        .vcount(vcount),
        .x(bullet2_x),
        .y(bullet2_y),
        .pixel(bullet2_pixel)
    );
   
    
    bullet_move2 movebullet2(
         .frame(frame),
         .clk(vclk),
         .rst(rst),
         .x(bullet2_x),
         .y(bullet2_y)
//         .win_rst(win_rst1)
    );
    
    
    draw_player1 player(
        .clk(vclk),
        .rst(rst),
        .frz(frz),
        .hcount(hcount),
        .vcount(vcount),
        .x(player_x),
        .y(player_y),
        .color_change(color_change),
        .pixel(player_pixel),
        .bullet1_x(bullet1_x),
        .bullet1_y(bullet1_y),
        .bullet2_x(bullet2_x),
        .bullet2_y(bullet2_y),
        .over(over)
    );
    
    player1_move moveplayer1(
    	.frame(frame), 
        .clk(vclk),
        .rst(rst),
        .frz(frz),
	    .up(up),
        .down(down),
        .right(right),
        .left(left),
        .x(player_x),
        .y(player_y),
        .pattern_select(pattern_select),
        .spi_x_out(spi_x_out),
        .spi_y_out(spi_y_out)
    );
    
    
    
    draw_board board1(
        .clk(vclk),
        .hcount(hcount),
        .vcount(vcount),
        .pixel(board_pixel)
    );
    
    final_out finalout(
        .clk(vclk),
        .rst(rst),
        .bullet1(bullet1_pixel),
        .bullet2(bullet2_pixel),
        .player(player_pixel),
        .board(board_pixel),
        .final_pixel(pixel),
        .over(over),
		.hcount(hcount),
        .vcount(vcount)
    );
    
    assign VGA_R=pixel[11:8];
    assign VGA_G=pixel[7:4];
    assign VGA_B=pixel[3:0];
    assign vsync = ~vs;
    assign hsync = ~hs;
endmodule

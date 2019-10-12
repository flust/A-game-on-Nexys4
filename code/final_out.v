`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 10:16:28
// Design Name: 
// Module Name: final_out
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


module final_out#(parameter WIDTH = 10,   
               HEIGHT = 40)(
    clk,
    rst,
    bullet1,
    bullet2,
    player,
    board,
    final_pixel,
    over,
    hcount,
    vcount
    );
    
    
    
    input clk;
    input rst;
    input [11:0]bullet1;
    input [11:0]bullet2;
    input [11:0]player;
    input [11:0]board;
    input [10:0]hcount;
    input [9:0]vcount;
    input over;
    output reg [11:0]final_pixel;
    
    reg [11:0]pixel_reg;
    
    
    reg [7:0] x = 120;
    reg [7:0] y = 245;
    
    
    always@(posedge clk)
    begin
        if(rst)final_pixel<=0;
        else
            if(over==0)
             final_pixel <= board | bullet1 | bullet2 | player;
            else
            begin
                if(over==1)
                  if (
                                    ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 6*WIDTH + 3*HEIGHT)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || //upper left vertical line                                     |
                                    ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 6*WIDTH + 3*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line   |
                                    ((hcount >= (x + 5*WIDTH + 3*HEIGHT) && hcount < (x + 7*WIDTH + 4*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line    +-----
                                    ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line                                                    +----+
                                    ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 9*WIDTH + 4*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper left vertical line                    |    |
                                    ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 9*WIDTH + 4*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower left vertical line   |    |
                                    ((hcount >= (x + 8*WIDTH + 4*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) || //lower horizontal line   |    |
                                    ((hcount >= (x + 9*WIDTH + 5*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line                    +----+
                                    ((hcount >= (x + 9*WIDTH + 5*HEIGHT) && hcount < (x + 10*WIDTH + 5*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) ||//lower right vertical line  +----+
                                    ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line                                                     |
                                    ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 12*WIDTH + 5*HEIGHT)) && (vcount >= (y + WIDTH) && vcount < (y + WIDTH + HEIGHT))) || //upper left vertical line                     +----+
                                    ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + HEIGHT))) || //middle vertical line                     |
                                    ((hcount >= (x + 12*WIDTH + 6*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 2*WIDTH + 2*HEIGHT))) || //lower right                  +----+        
                                    ((hcount >= (x + 11*WIDTH + 5*HEIGHT) && hcount < (x + 13*WIDTH + 6*HEIGHT)) && (vcount >= (y + 2*WIDTH + 2*HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT))) ||//lower horizontal line     +-+--+
                                    ((hcount >= (x + 14*WIDTH + 6*HEIGHT) && hcount < (x + 16*WIDTH + 7*HEIGHT)) && (vcount >= y && vcount < (y + WIDTH))) || //upper horizontal line                                                         |
                                    ((hcount >= (x + 14*WIDTH + 6*HEIGHT + HEIGHT/2) && hcount < (x + 15*WIDTH + 6*HEIGHT + HEIGHT/2)) && (vcount >= y && vcount < (y + 2*WIDTH + HEIGHT))) || //upper right vertical line                    |
                                    ((hcount >= (x + 14*WIDTH + 6*HEIGHT + HEIGHT/2) && hcount < (x + 15*WIDTH + 6*HEIGHT + HEIGHT/2)) && (vcount >= (y + 2*WIDTH + HEIGHT) && vcount < (y + 3*WIDTH + 2*HEIGHT)))//lower right             |
                                   )
                                   pixel_reg <= 12'h0FF;
                               else 
                                   pixel_reg <= 12'b0;
                  final_pixel<=pixel_reg;     
       end
    end
    
endmodule

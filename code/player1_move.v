`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 10:15:44
// Design Name: 
// Module Name: player1_move
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


module player1_move #(parameter X = 500, Y = 200)(
    	frame, 
        clk,
        rst,
        frz,
        up,
        down,
        right,
        left,
        x,
        y,
        pattern_select,
        spi_x_out,
        spi_y_out
    );
    input frame;
    input clk;
    input rst;
    input frz;
    input up;
    input down;
    input right;
    input left;
    output reg [10:0]x;
    output reg [9:0]y;

    input pattern_select;
    input [3:0]spi_x_out;
    input [3:0]spi_y_out;
    
    
    reg signed [3:0]v_x;
    reg signed [3:0]v_y;
    reg [1:0]xdirect;//标志 0表示向左，1表示向右,2表示左右无位移
    reg [1:0]ydirect;//标志，0表示向上，1表示向下，2表示上下无位移
    
      
    always@(posedge clk)
    begin

        if ( rst ) 
            begin
                      x<=X;
                      y<=Y;
                      v_x<=1;
                      v_y<=1;
            end
        else if ( frame == 1 ) 
        begin
            if(pattern_select==0)
            begin
               if(left)x<=x-v_x;
               if(right)x<=x+v_x;
               
               if(up)y<=y-v_y;
               if(down)y<=y+v_y;
            end
            else 
            begin
                if(spi_x_out==1||spi_x_out==2)x<=x-v_x;
                else if(spi_x_out==3||spi_x_out==4)x<=x-2*v_x;
                else if(spi_x_out==4'b1110||spi_x_out==4'b1101)x<=x+v_x;
                else if(spi_x_out==4'b1100||spi_x_out==4'b1011)x<=x+2*v_x;
                
                if(spi_y_out==1||spi_y_out==2)y<=y+v_y;
                else if(spi_y_out==3||spi_y_out==4)y<=y+2*v_y;
                else if(spi_y_out==4'b1110||spi_y_out==4'b1101)y<=y-v_y;
                else if(spi_y_out==4'b1100||spi_y_out==4'b1011)y<=y-2*v_y;
            end
        end
        

    end
    
    
endmodule
                
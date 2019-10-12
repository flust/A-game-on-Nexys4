`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/27 12:42:53
// Design Name: 
// Module Name: bullet_move2
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



module bullet_move2 #(parameter X=200,Y=500)(
        frame,
        clk,
        rst,
        x,
        y
 //       win_rst
//        player_x,
 //       player_y,
 //       over
    );
    input frame;
    input clk;
    input rst;
//    output reg win_rst;
    output reg [10:0]x;
    output reg [9:0]y;
 //   input [9:0]player_x;
 //   input [9:0]player_y;
 //   output wire over;
    
    reg over_reg;
//    assign over=over_reg;
    reg [1:0] v_x;
    reg [1:0] v_y;
    reg sw_x;//标志 0表示向左，1表示向右
    reg sw_y;//标志，0表示向上，1表示向下
    
    reg [3:0]tcount;//根据时间修改速度
    
    always@(negedge clk)
    begin
             if(x<=2)begin sw_x<=1;end
             else if(x>=762)begin sw_x<=0;end
      
             if(y<=36)begin sw_y<=1;end
             else if (y>=562)begin sw_y<=0;end
    
    end
    
    
    always@(posedge clk)
    begin
        if(rst )
        begin
            x<=X;
            y<=Y;
            v_x<=2;
            v_y<=3;
        end
        else if ( frame == 1 ) 
        begin
              if(sw_x==0)x<=x-v_x;
              else x<=x+v_x;
              
              if(sw_y==0)y<=y-v_y;
              else y<=y+v_y;
              
              
        end
    
    end
endmodule
    

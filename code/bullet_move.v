`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 10:15:09
// Design Name: 
// Module Name: bullet_move
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


module bullet_move #(parameter X=500,Y=500)(
        frame,
        clk,
        rst,
        score,
        x,
        y,
        over
    );
    input frame;
    input clk;
    input rst;
    output reg [15:0]score;  //得分
    output reg [10:0]x;
    output reg [9:0]y;
    input over;
    
    reg over_reg;
    reg [1:0] v_x;
    reg [1:0] v_y;
    reg sw_x;//标志 0表示向左，1表示向右
    reg sw_y;//标志，0表示向上，1表示向下
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            x<=X;
            y<=Y;
            v_x<=2;
            v_y<=2;
            score<=0;
        end
        else if ( frame == 1 &&over==0) 
        begin
                    if(x==2||x==3)begin sw_x<=1;score<=score+1'b1;end
                     else if(x==762||x==761)begin sw_x<=0;score<=score+1'b1;end
        
                     if(y==36||y==37)begin sw_y<=1;score<=score+1'b1;end
                     else if (y==562||y==561)begin sw_y<=0;score<=score+1'b1;end
                     
                     
              if(sw_x==0)x<=x-v_x;
              else x<=x+v_x;
              
              if(sw_y==0)y<=y-v_y;
              else y<=y+v_y;
              
              
                   if(score[3:0]==10)
                            begin score[3:0]<=0;score[7:4]<=score[7:4]+1;end
                            if(score[7:4]==10)
                            begin score[7:4]<=0;score[11:8]<=score[11:8]+1;end
                            if(score[11:8]==10)
                            begin score[11:8]<=0;score[15:12]<=score[15:12]+1;end
                            if(score[15:12]==10)
                            begin score[11:8]<=0;end      
        end
    
    
    end
endmodule

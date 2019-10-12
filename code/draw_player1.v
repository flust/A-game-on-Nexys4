`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 10:15:32
// Design Name: 
// Module Name: draw_player1
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


module draw_player1(
        clk,
        rst,
        frz,
        color_change,
        hcount,
        vcount,
        x,
        y,
        pixel,
        bullet1_x,
        bullet1_y,
        bullet2_x,
        bullet2_y,
        over
    );
    input clk;
    input rst;
    input frz;
    input color_change;
    input [10:0]hcount;
    input [9:0]vcount;
    input [10:0]x;
    input [9:0]y;
    output wire [11:0]pixel;
    input [10:0]bullet1_x;
    input [9:0]bullet1_y;
    input [10:0]bullet2_x;
    input [9:0]bullet2_y;
    output reg over;
    reg [11:0]pixel_reg;
    
    assign pixel=pixel_reg;

    
    reg [11:0]color_reg;
    integer R=10;
    reg [31:0]count;
    
    always@(posedge clk)
    begin
        if(frz)begin color_reg<=12'b0110_1100_0011;over<=0;end
        if(~frz)
         count <=count+1;
         if(count[25]==1&&color_change==0&&R>7)
         begin
            R<=R-2;
            count[25]<=0;
            color_reg<=color_reg+12'b0011_0011_0011;
         end
         if(count[24]==1)
         begin
                count[24] <=0;
                count[25]<=~count[25];
                R<=R+1;
         end
         
         if(x<2+R||(x+R)>762||(y-R)<36||(y+R)>562||
                  ((x-bullet1_x)*(x-bullet1_x)+(y-bullet1_y)*(y-bullet1_y)<(R+12)*(R+12))
                  ||
                  ((x-bullet2_x)*(x-bullet2_x)+(y-bullet2_y)*(y-bullet2_y)<(R+12)*(R+12))
                  )
         begin over<=1;R<=400;end
         else over<=0;
    end
       
    
    always@(posedge clk)
    begin
        
        if ((hcount-x)*(hcount-x)+(vcount-y)*(vcount-y)<R*R)
        begin
                 pixel_reg<=color_reg;
        end
        else pixel_reg<=12'b0;
    end
    
    
endmodule

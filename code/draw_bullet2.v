`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 10:22:36
// Design Name: 
// Module Name: draw_bullet2
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


module draw_bullet2 #(parameter R=12)(
        clk,
        hcount,
        vcount,
        x,
        y,
        pixel
    );
    input clk;
    input [10:0]hcount;
    input [9:0]vcount;
    output wire [11:0]pixel;
    input [10:0]x;
    input [9:0]y;
    
    reg[11:0]color;
    
    always@(posedge clk)
    begin
        if ((hcount-x)*(hcount-x)+(vcount-y)*(vcount-y)<=R*R)
            color<=12'b1111_1111_1111;
        else
            color<=12'b0;
    end
    assign pixel=color;
endmodule

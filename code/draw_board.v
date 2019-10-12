`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/22 10:17:57
// Design Name: 
// Module Name: draw_board
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


module draw_board(
     clk,
     hcount,
     vcount,
     pixel
    );
    input clk;
    input [10:0] hcount;
    input [9:0] vcount;
    output wire [11:0] pixel;
    
    reg [11:0]pixel_reg;
    assign pixel=pixel_reg;
    
    always @ (posedge clk)
    begin
        if ( hcount == 0 || vcount == 30 || hcount == 768 || vcount == 568 )
            pixel_reg <= 12'hFFF;
        else
            pixel_reg <= 12'b0;
    end
    
    
endmodule

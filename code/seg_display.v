`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/25 14:15:16
// Design Name: 
// Module Name: seg_display
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


module seg_display(
        clk,
        seven_seg,
        sel,
        over,
        idata
    );
    input clk;
    input[15:0]idata;
    output [7:0]seven_seg;
    output [7:0]sel;
    input over;
    reg [31:0] count;
    reg [7:0]seg_reg;
    reg[7:0]sel_reg;
    reg [3:0]disp_data;
    assign seven_seg=seg_reg;
    assign sel=sel_reg;
    /*
    reg [15:0]score_reg;
    always@(posedge clk)
    begin
        if(over==0)score_reg<=idata;
        else score_reg<=score_reg;
    end
    */
    always@(posedge clk)
    begin
         count <=count+1;
         if(count==500000)
                count <=1;
    end
       
    always@(count[13:11])    
             begin
                 case(count[13:11])
                 3'b000:disp_data<=idata[3:0];
                 3'b001:disp_data<=idata[7:4];
                 3'b010:disp_data<=idata[11:8];
                 3'b011:disp_data<=idata[15:12];             
                 default:disp_data<=4'b1111;
                 endcase
    end 
       
    always@(disp_data)
    begin
            case(disp_data)
            4'h0: seg_reg=8'hc0;
            4'h1: seg_reg=8'hf9;
            4'h2: seg_reg=8'ha4;
            4'h3: seg_reg=8'hb0;
            4'h4: seg_reg=8'h99;
            4'h5: seg_reg=8'h92;
            4'h6: seg_reg=8'h82;
            4'h7: seg_reg=8'hf8;
            4'h8: seg_reg=8'h80;
            4'h9: seg_reg=8'h90;
            default:seg_reg<=8'hff;
            endcase
    end
    
    always@(count[13:11])
           begin
               case(count[13:11])
               3'b000:sel_reg<=8'b1111_1110;
               3'b001:sel_reg<=8'b1111_1101;
               3'b010:sel_reg<=8'b1111_1011;
               3'b011:sel_reg<=8'b1111_0111;
               3'b100:sel_reg<=8'b1110_1111;
               3'b101:sel_reg<=8'b1101_1111;
               3'b110:sel_reg<=8'b1011_1111;
               3'b111:sel_reg<=8'b0111_1111;
               endcase
     end
       
    
    
endmodule

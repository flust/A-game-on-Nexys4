`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/25 18:51:12
// Design Name: 
// Module Name: ClkDiv_50MHz
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


module ClkDiv_50MHz(
		CLK,
RST,
CLKOUT
);

input             CLK;        // 100MHz onboard clock
input             RST;        // Reset
output         CLKOUT;    // New clock output
reg              CLKOUT;
reg              flag;

always @(posedge CLK or posedge RST)
    // Reset clock
    if (RST == 1'b1) 
    begin
        CLKOUT <= 0;
        flag <= 0;
    end
    else 
    begin
        if (flag == 1)
        begin
            CLKOUT <= ~CLKOUT;
            flag <= 0;
        end
        else 
        begin
            flag <= 1;
        end
    end
endmodule

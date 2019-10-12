`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 13:55:11
// Design Name: 
// Module Name: spi_module
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


module spi_module
(
    input               I_clk       , // 全局时钟50MHz
    input               I_rst_n     , // 复位信号，低电平有效
    input               I_tx_en     , // 发送使能信号
    input        [15:0]  I_data_in   , // 要发送的数据
    output  reg  [7:0]  O_data_out  , // 接收到的数据
    
    // 四线标准SPI信号定义
    input               I_spi_miso  , // SPI串行输入，用来接收从机的数据
    output  reg         O_spi_sck   , // SPI时钟
    output  reg         O_spi_cs    , // SPI片选信号
    output  reg         O_spi_mosi    // SPI输出，用来给从机发送数据          
);

reg [5:0]   state      ; 

always @(posedge I_clk or negedge I_rst_n)
begin
    if(!I_rst_n)
        begin
            state  <=  6'd0    ;
            O_spi_cs    <=  1'b1    ;
            O_spi_sck   <=  1'b0    ;
            O_spi_mosi  <=  1'b0    ;
            O_data_out  <=  8'd0    ;
        end 
    else if(I_tx_en) // 发送使能信号打开的情况下
        begin
            if(state==6'd50)
            begin
                state  <=  6'd0                    ; 
            end 
             O_spi_cs    <=  1'b0    ; // 把片选CS拉低
            case(state)
                6'd1, 6'd3 , 6'd5 , 6'd7  , 
                6'd9, 6'd11, 6'd13, 6'd15 ,
                6'd17, 6'd19, 6'd21, 6'd23 ,
                6'd25 , 6'd27, 6'd29, 6'd31 : 
                //整合奇数状态
                    begin
                        O_spi_sck   <=  1'b1                ;
                        state  <=  state + 1'b1   ;
                    end
                6'd0:    // 发送第15位
                    begin
                        O_spi_mosi  <=  I_data_in[15]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;          
                    end
                6'd2:    // 发送第14位
                    begin
                        O_spi_mosi  <=  I_data_in[14]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end
                6'd4:    // 发送第13位
                    begin
                        O_spi_mosi  <=  I_data_in[13]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd6:    // 发送第12位
                    begin
                        O_spi_mosi  <=  I_data_in[12]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd8:    // 发送第11位
                    begin
                        O_spi_mosi  <=  I_data_in[11]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end                            
                6'd10:    // 发送第10位
                    begin
                        O_spi_mosi  <=  I_data_in[10]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd12:    // 发送第9位
                    begin
                        O_spi_mosi  <=  I_data_in[9]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd14:    // 发送第8位
                    begin
                        O_spi_mosi  <=  I_data_in[8]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end
                                   6'd16:    // 发送第7位
                                       begin
                                           O_spi_mosi  <=  I_data_in[7]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end
                                   6'd18:    // 发送第6位
                                       begin
                                           O_spi_mosi  <=  I_data_in[6]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end
                                   6'd20:    // 发送第5位
                                       begin
                                           O_spi_mosi  <=  I_data_in[5]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd22:    // 发送第4位
                                       begin
                                           O_spi_mosi  <=  I_data_in[4]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd24:    // 发送第3位
                                       begin
                                           O_spi_mosi  <=  I_data_in[3]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end                            
                                   6'd26:    // 发送第2位
                                       begin
                                           O_spi_mosi  <=  I_data_in[2]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd28:    // 发送第1位
                                       begin
                                           O_spi_mosi  <=  I_data_in[1]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd30:    // 发送第0位
                                       begin
                                           O_spi_mosi  <=  I_data_in[0]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end
                   
                6'd32, 6'd34 , 6'd36 , 6'd38  , 
                6'd40, 6'd42, 6'd44, 6'd46, 6'd48 : //整合偶数状态
                    begin
                        O_spi_sck  <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end
                6'd33:    // 接收第7位
                    begin                       
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                     //   O_data_out[7]   <=  I_spi_miso          ;   
                    end
                6'd35:    // 接收第6位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[7]   <=  I_spi_miso          ; 
                    end
                6'd37:    // 接收第5位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[6]   <=  I_spi_miso          ; 
                    end 
                6'd39:    // 接收第4位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[5]   <=  I_spi_miso          ; 
                    end 
                6'd41:    // 接收第3位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[4]   <=  I_spi_miso          ; 
                    end                            
                6'd43:    // 接收第2位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[3]   <=  I_spi_miso          ; 
                    end 
                6'd45:    // 接收第1位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[2]   <=  I_spi_miso          ; 
                    end 
                6'd47:    // 接收第0位
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[1]   <=  I_spi_miso          ; 
                    end
                        6'd49:    // 接收第0位
                                 begin
                                     O_spi_sck       <=  1'b1                ;
                                     state      <=  state + 1'b1   ;
                                     O_data_out[0]   <=  I_spi_miso          ; 
                                      O_spi_cs<=1'b1;
                                 end
                default:;//state  <=  6'd0                    ;   
            endcase 
        end    
    else
        begin
            state  <=  6'd0    ;
            O_spi_cs    <=  1'b1    ;
            O_spi_sck   <=  1'b0    ;
            O_spi_mosi  <=  1'b0    ;
            O_data_out  <=  8'd0    ;
        end   
           
end

endmodule

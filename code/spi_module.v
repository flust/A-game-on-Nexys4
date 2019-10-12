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
    input               I_clk       , // ȫ��ʱ��50MHz
    input               I_rst_n     , // ��λ�źţ��͵�ƽ��Ч
    input               I_tx_en     , // ����ʹ���ź�
    input        [15:0]  I_data_in   , // Ҫ���͵�����
    output  reg  [7:0]  O_data_out  , // ���յ�������
    
    // ���߱�׼SPI�źŶ���
    input               I_spi_miso  , // SPI�������룬�������մӻ�������
    output  reg         O_spi_sck   , // SPIʱ��
    output  reg         O_spi_cs    , // SPIƬѡ�ź�
    output  reg         O_spi_mosi    // SPI������������ӻ���������          
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
    else if(I_tx_en) // ����ʹ���źŴ򿪵������
        begin
            if(state==6'd50)
            begin
                state  <=  6'd0                    ; 
            end 
             O_spi_cs    <=  1'b0    ; // ��ƬѡCS����
            case(state)
                6'd1, 6'd3 , 6'd5 , 6'd7  , 
                6'd9, 6'd11, 6'd13, 6'd15 ,
                6'd17, 6'd19, 6'd21, 6'd23 ,
                6'd25 , 6'd27, 6'd29, 6'd31 : 
                //��������״̬
                    begin
                        O_spi_sck   <=  1'b1                ;
                        state  <=  state + 1'b1   ;
                    end
                6'd0:    // ���͵�15λ
                    begin
                        O_spi_mosi  <=  I_data_in[15]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;          
                    end
                6'd2:    // ���͵�14λ
                    begin
                        O_spi_mosi  <=  I_data_in[14]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end
                6'd4:    // ���͵�13λ
                    begin
                        O_spi_mosi  <=  I_data_in[13]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd6:    // ���͵�12λ
                    begin
                        O_spi_mosi  <=  I_data_in[12]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd8:    // ���͵�11λ
                    begin
                        O_spi_mosi  <=  I_data_in[11]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end                            
                6'd10:    // ���͵�10λ
                    begin
                        O_spi_mosi  <=  I_data_in[10]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd12:    // ���͵�9λ
                    begin
                        O_spi_mosi  <=  I_data_in[9]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end 
                6'd14:    // ���͵�8λ
                    begin
                        O_spi_mosi  <=  I_data_in[8]        ;
                        O_spi_sck   <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end
                                   6'd16:    // ���͵�7λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[7]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end
                                   6'd18:    // ���͵�6λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[6]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end
                                   6'd20:    // ���͵�5λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[5]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd22:    // ���͵�4λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[4]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd24:    // ���͵�3λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[3]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end                            
                                   6'd26:    // ���͵�2λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[2]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd28:    // ���͵�1λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[1]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end 
                                   6'd30:    // ���͵�0λ
                                       begin
                                           O_spi_mosi  <=  I_data_in[0]        ;
                                           O_spi_sck   <=  1'b0                ;
                                           state  <=  state + 1'b1   ;
                                       end
                   
                6'd32, 6'd34 , 6'd36 , 6'd38  , 
                6'd40, 6'd42, 6'd44, 6'd46, 6'd48 : //����ż��״̬
                    begin
                        O_spi_sck  <=  1'b0                ;
                        state  <=  state + 1'b1   ;
                    end
                6'd33:    // ���յ�7λ
                    begin                       
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                     //   O_data_out[7]   <=  I_spi_miso          ;   
                    end
                6'd35:    // ���յ�6λ
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[7]   <=  I_spi_miso          ; 
                    end
                6'd37:    // ���յ�5λ
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[6]   <=  I_spi_miso          ; 
                    end 
                6'd39:    // ���յ�4λ
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[5]   <=  I_spi_miso          ; 
                    end 
                6'd41:    // ���յ�3λ
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[4]   <=  I_spi_miso          ; 
                    end                            
                6'd43:    // ���յ�2λ
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[3]   <=  I_spi_miso          ; 
                    end 
                6'd45:    // ���յ�1λ
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[2]   <=  I_spi_miso          ; 
                    end 
                6'd47:    // ���յ�0λ
                    begin
                        O_spi_sck       <=  1'b1                ;
                        state      <=  state + 1'b1   ;
                        O_data_out[1]   <=  I_spi_miso          ; 
                    end
                        6'd49:    // ���յ�0λ
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

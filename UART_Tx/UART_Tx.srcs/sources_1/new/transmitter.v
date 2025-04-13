`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 15:47:36
// Design Name: 
// Module Name: transmitter
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


module transmitter(
    input clk,
    input [7:0] data,
    input transmit,
    input reset,
    output reg TxD
    );
    
    reg [3:0] bit_counter;
    reg [13:0] baud_counter;
    reg [9:0] shiftright_register;
    
    reg state, next_state;
    reg shift,load, clear;
    
    always @(posedge clk)begin
        if(reset)begin
            state<=0;
            bit_counter<=0;
            baud_counter<=0;
        end
        else begin
            baud_counter<=baud_counter+1;
            if(baud_counter==10415)begin
                state<=next_state;
                baud_counter<=0;
                if(load) shiftright_register<={1'b1,data,1'b0};
                if(clear) bit_counter<=0;
                if(shift)begin
                    shiftright_register<=shiftright_register>>1;
                    bit_counter<=bit_counter+1;
                end
            end
        end
    end

    always @(posedge clk)begin
        load<=0;
        shift<=0;
        clear<=0;
        TxD<=1;

        case(state)
            0:begin
                if(transmit)begin
                    next_state<=1;
                    load<=1;
                    shift<=0;
                    clear<=0;
                end
                else begin
                    next_state<=0;
                    TxD<=1;
                end
            end
            1:begin
                if(bit_counter==10)begin
                    next_state<=0;
                    clear<=1;
                end
                else begin
                    TxD<=shiftright_register[0];
                    next_state<=1;
                    shift<=1;
                end
            
            end
            default: next_state <= 0;
        endcase

    end

endmodule 



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.04.2025 00:00:46
// Design Name: 
// Module Name: Receiver_RxD
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


module Receiver_RxD(
    input clk_fpga,
    input reset,
    input RxD,
    output [7:0] RxData
    );
    
    reg shift;
    reg state,nextstate;
    reg [3:0] bit_counter;
    reg [13:0] counter;
    reg [1:0] sample_counter;
    reg [9:0] rxshift_reg;
    reg clear_bitcounter,inc_bitcounter,clear_samplecounter,inc_samplecounter;
    
    
    parameter clk_frequency=100000000;
    parameter baud_rate=9600;
    parameter div_sample=4;
    parameter div_counter=clk_frequency/(baud_rate*div_sample);
    parameter mid_sample=2;
    parameter div_bit=10;
    
    assign RxData= rxshift_reg[8:1] ;
    
    always @(posedge clk_fpga)begin
        if(reset)begin
            state<=0;
            bit_counter<=0;
            counter<=0;
            sample_counter<=0;
        end
        else begin
            counter<=counter+1;
            if(counter>=div_counter-1)begin
                counter<=0;
                state<=nextstate;
                if(shift) rxshift_reg={RxD,rxshift_reg[9:1]};
                if(clear_bitcounter) bit_counter<=0;
                if(clear_samplecounter) sample_counter<=0;
                if(inc_bitcounter) bit_counter<=bit_counter+1;
                if(inc_samplecounter) sample_counter<=sample_counter+1;
            end
        end
    end
    
    always @(posedge clk_fpga) begin
        shift<=0;
        clear_bitcounter<=0;
        inc_bitcounter<=0;
        clear_samplecounter<=0;
        inc_samplecounter<=0;
        case(state)
        0:begin
            if(RxD)begin
                nextstate<=0;
            end
            else begin
                nextstate<=1;
                clear_bitcounter<=1;
                clear_samplecounter<=1;
            end
        end
        1:begin
            nextstate<=1;
            if(sample_counter==mid_sample-1) shift<=1;
            if(sample_counter==div_sample-1) begin
                if(bit_counter==div_bit-1)begin
                    nextstate<=0;
                end
                inc_bitcounter<=1;
                clear_samplecounter<=1;
             end
             else inc_samplecounter<=1;
        end
        default: nextstate<=0;
        endcase
    end
    
    
endmodule

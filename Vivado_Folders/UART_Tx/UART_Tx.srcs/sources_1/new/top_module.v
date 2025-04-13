`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 17:56:12
// Design Name: 
// Module Name: top_module
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


module top_module(
    input clk,
    input transmit,
    input button,
    input [7:0] data,
    output TxD,
    output TxD_debug,
    output transmit_debug,
    output btn_debug,
    output clk_debug
    );
    
    wire transmit_out;
   
    transmitter T1(.clk(clk),.data(data),.reset(transmit),.transmit(transmit_out),.TxD(TxD));
    debounce_signals DB1(.clk(clk),.btn(button),.transmit(transmit_out));
    
    assign TxD_debug=TxD;
    assign transmit_debug=transmit_out;
    assign btn_debug=button;
    assign clk_debug=clk;
    
endmodule

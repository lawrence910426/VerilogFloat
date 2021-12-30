`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2021 09:05:09 PM
// Design Name: 
// Module Name: Timing_Test
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


module Timing_Test(
    input [32 - 1:0] a,
    input [32 - 1:0] b,
    input clk,
    output [32 - 1:0] out
);
    reg [32 - 1:0] temp;
    wire [32 - 1:0] x;
    
    FLOAT32_MUL chip (
        .a(a),
        .b(b),
        .out(x),
        .clk(clk)
    );
    
    always @ (posedge clk) temp <= x;
    assign out = temp;
endmodule

module FLOAT32_ADD_PIPELINE(
    input [32 - 1:0] a,
    input [32 - 1:0] b,
    input clk,
    output reg [32 - 1:0] out
);
    parameter clocks = 2, logcount = 1;

    reg [32 - 1:0] A [clocks - 1:0], B [clocks - 1:0];
    reg [logcount - 1:0] state;
    wire [32 - 1:0] OUT [clocks - 1:0];
    
    genvar i;
    generate for (i = 0; i < clocks; i = i + 1) begin
        FLOAT32_ADD chip (.a(A[i]), .b(B[i]), .out(OUT[i]));
    end endgenerate
    
    always @ (posedge clk) begin
        state <= state + 1;
        A[state] <= a;
        B[state] <= b;
        out <= OUT[state];
    end
endmodule

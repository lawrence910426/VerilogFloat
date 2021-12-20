module FLOAT_TO_INT(
    input [32 - 1:0] in,
    output [32 - 1:0] out
);
    wire [31 - 1:0] Value, ValueFixed;
    
    assign
        Value = (
            in[31 - 1:23] > 8'b0111_1111 + 8'd24 ?
            {7'b000_0000, 1'b1, in[23 - 1:0]} << (in[31 - 1:23] - 8'b0111_1111 - 8'd24) :
            {7'b000_0000, 1'b1, in[23 - 1:0]} >> (8'b0111_1111 + 8'd24 - in[31 - 1:23])
        ),
        ValueFixed = (
            in[31 - 1:23] > 8'b0111_1111 + 8'd24 + 8'd7 ?
            31'b111_1111_1111_1111_1111_1111_1111_1111 :
            Value
        ),
        out = {in[31], (
            in[31] == 1'b0 ?
            ValueFixed :
            ~ValueFixed + 31'd1
        )};
endmodule

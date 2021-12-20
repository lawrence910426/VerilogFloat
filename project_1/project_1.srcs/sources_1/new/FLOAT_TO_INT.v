module FLOAT_TO_INT(
    input [32 - 1:0] in,
    output [32 - 1:0] out
);
    wire [31 - 1:0] Value, ValueFixed;
    
    assign
        Value = (
            in[31 - 1:23] > 8'b1000_0000 ?
            {1'b1, in[23 - 1:0]} << (in[31 - 1:23] - 8'b1000_0000) :
            {1'b1, in[23 - 1:0]} >> (8'b1000_0000 - in[31 - 1:23])
        ),
        ValueFixed = (
            in[31 - 1:23] > 8'b1000_0000 + 8'd32 ?
            31'b111_1111_1111_1111_1111_1111_1111_1111:
            {1'b0, Value}
        ),
        out = (
            in[31] == 1'b1 ?
            ValueFixed :
            32'b1000_0000_0000_0000_0000_0000_0000_0000 - {1'b0, ValueFixed}
        );
endmodule

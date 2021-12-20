module INT_TO_FLOAT(
    input [32 - 1:0] in,
    output [32 - 1:0] out
);
    wire Sign;
    wire [32 - 1:0] Value;
    wire [5 - 1:0] Highest;
    wire [8 - 1:0] Exponent;
    wire [23 - 1:0] Mantissa;
    wire [9 - 1:0] Dummy_bit_mantissa;
    
    assign Value = (
        in[31] == 1'b0 ? in[30:0] :
        32'b1000_0000_0000_0000_0000_0000_0000_0000 - {1'b0, in[30:0]}
    );
    
    ENCODER_32 encoder (
        .in(Value),
        .out(Highest)
    );
    
    assign
        Sign = in[31],
        Exponent = 8'b1000_0000 + Highest,
        { Dummy_bit_mantissa, Mantissa } = (
            Highest > 5'd23 ? 
            Value >> (Highest - 5'd23) :
            Value << (5'd23 - Highest)
        );
    
    assign out = { Sign, Exponent, Mantissa };
endmodule

module FLOAT32_MUL(a, b, out);
    input [32 - 1:0] a, b;
    output [32 - 1:0] out;
    
    wire [24 + 24 - 1:0] Computed_mantissa;
    wire signed [8 - 1:0] A_exponent_2comp, B_exponent_2comp;
    wire signed [9 - 1:0] Computed_exponent;
    wire [6 - 1:0] Highest_bit;
    
    wire Output_sign;
    wire [23 - 1:0] Output_mantissa;
    wire [8 - 1:0] Output_exponent;
    
    FLOAT_EXP_TO_2COMP 
        A (
            .in(a[30:23]),
            .out(A_exponent_2comp)
        ),
        B (
            .in(b[30:23]),
            .out(B_exponent_2comp)
        );
    
    assign
        Computed_mantissa = {1'b1, a[23 - 1:0]} * {1'b1, b[23 - 1:0]},
        Computed_exponent = A_exponent_2comp + B_exponent_2comp;
        
    ENCODER_64 encoder (
        .in(Computed_mantissa),
        .out(Highest_bit)
    );
    
    assign
        Output_sign = a[32 - 1] ^ b[32 - 1],
        Output_mantissa = Computed_mantissa >> (Highest_bit - 6'd23);
endmodule

module FLOAT_EXP_TO_2COMP (in, out);
    input [8 - 1:0] in;
    output [8 - 1:0] out;
    
    wire [8 - 1:0] complement;
    assign 
        complement = 8'b1000_0000 - in,
        out = (
            in[7] == 1'b1 ?
            {1'b0, in[6:0]} :
            {1'b1, complement[6:0]}
        );
endmodule
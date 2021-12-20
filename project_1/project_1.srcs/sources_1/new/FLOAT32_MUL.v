module FLOAT32_MUL(a, b, out);
    input [32 - 1:0] a, b;
    output [32 - 1:0] out;
    
    wire Dummy_bit_exponent;
    wire [24 + 24 - 1:0] Computed_mantissa;
    wire [9 - 1:0] Computed_exponent;
    wire [6 - 1:0] Highest_bit;
    
    wire Output_sign;
    wire [23 - 1:0] Output_mantissa;
    wire [8 - 1:0] Output_exponent;
    
    assign
        Computed_mantissa = {1'b1, a[23 - 1:0]} * {1'b1, b[23 - 1:0]},
        Computed_exponent = a[30:23] + b[30:23] + (Highest_bit - 6'd23);
        
    ENCODER_64 encoder (
        .in(Computed_mantissa),
        .out(Highest_bit)
    );
    
    assign
        Output_sign = a[32 - 1] ^ b[32 - 1],
        Output_mantissa = Computed_mantissa >> (Highest_bit - 6'd23),
        { Dummy_bit_exponent, Output_exponent } = (
            Computed_exponent < 9'b0_1000_0000 ? 9'b0_0000_0000 :
            Computed_exponent >= 9'b1_1000_0000 ? 9'b0_1111_1111 :
            Computed_exponent - 9'b0_1000_0000
        );
        
    assign out = { Output_sign, Output_exponent, Output_mantissa };
endmodule

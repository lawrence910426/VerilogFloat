module FLOAT32_ADD (a, b, out);
    input [32 - 1:0] a, b;
    output [32 - 1:0] out;
    
    // A is the one with greater absolute value
    // B is the one with smaller absolute value
    wire [32 - 1:0] A, B;
    
    // A sign is the sign of a
    // B sign is the sign of b
    wire A_sign, B_sign;
    
    // A exp is the exponent of A
    // B exp is the exponent of B
    // Diff exp is the differences of their exponent
    wire [8 - 1:0] A_exp, B_exp, Diff_exp;
    
    // A mantissa is the mantissa of A
    // B mantissa is the mantissa of B
    // Shifted B mantissa is B mantissa shifted for Diff exp
    wire [23 - 1:0] A_mantissa, B_mantissa, Shifted_B_mantissa;
    
    // Computed mantissa is the mantissa of computed result
    // Exponent shift is __lg(Computed_mantissa)
    // 
    wire [26 - 1:0] Computed_mantissa;
    wire [5 - 1:0] Highest_bit;
    wire [9 - 1:0] Computed_Exponent;
    
    
    //
    //
    //
    wire Output_sign;
    wire Dummy_bit_exponent;
    wire [3 - 1:0] Dummy_bit_mantissa;
    wire [8 - 1:0] Output_exponent;
    wire [23 - 1:0] Output_mantissa;
    
    assign 
        A = (a[30:0] > b[30:0] ? a : b),
        B = (a[30:0] < b[30:0] ? a : b),
        
        A_sign = A[31],
        B_sign = B[31],
        
        A_exp = A[30:23],
        B_exp = B[30:23],
        Diff_exp = A_exp - B_exp,
        
        A_mantissa = A[23 - 1:0],
        B_mantissa = B[23 - 1:0],
        
        Shifted_B_mantissa = B_mantissa >> Diff_exp,
        
        Computed_mantissa = (
            A_sign == B_sign ?
            {1'b1, A_mantissa} + {1'b1, B_mantissa} :
            {1'b1, A_mantissa} - {1'b1, B_mantissa}
        );
    
    ENCODER_32 encoder (
        .in({6'b00_0000, Computed_mantissa}),
        .out(Highest_bit)
    );
    
    assign
        Computed_exponent = A_exp + Highest_bit,
        
        Output_sign = A_sign,
        { Dummy_bit_exponent, Output_exponent } = (
            Computed_exponent > 9'b0_1111_1111 ? 9'b0_1111_1111 :
            Computed_exponent < 9'd23 ? 9'b0_0000_0000 :
            Computed_exponent - 9'd23
        ),
        { Dummy_bit_mantissa, Output_mantissa } = (
            Highest_bit < 5'd23 ?  
            Computed_mantissa << (5'd23 - Highest_bit) :
            Computed_mantissa >> (Highest_bit - 5'd23)
        );
    
    assign out = { Output_sign, Output_exponent, Output_mantissa };
endmodule


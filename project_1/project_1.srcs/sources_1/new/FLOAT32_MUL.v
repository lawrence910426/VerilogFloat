// Takes 2 clocks to complete
// Critical time is around 6.3 ns on desired fpga

module FLOAT32_MUL(a, b, out, clk);
    input [32 - 1:0] a, b;
    input clk;
    output [32 - 1:0] out;
    
    wire Dummy_bit_exponent;
    reg [24 + 24 - 1:0] Computed_mantissa;
    wire [9 - 1:0] Computed_exponent;
    wire [6 - 1:0] Highest_bit_wire;
    reg [6 - 1:0] Highest_bit;
    
    wire Output_sign;
    wire [23 - 1:0] Output_mantissa;
    wire [8 - 1:0] Output_exponent;
    
    // propagate a, b
    always @ (posedge clk)
        Computed_mantissa = {1'b1, a[23 - 1:0]} * {1'b1, b[23 - 1:0]};
        
    ENCODER_64 encoder (
        .in({16'b0, Computed_mantissa}),    
        .out(Highest_bit_wire)
    );

    // propagate a, b, computed_mantissa
    always @ (posedge clk)
        Highest_bit <= Highest_bit_wire;
        
    assign
        Computed_exponent = a[30:23] + b[30:23] + (Highest_bit - 6'd23 - 6'd23),
    
        Output_sign = a[32 - 1] ^ b[32 - 1],
        Output_mantissa = Computed_mantissa >> (Highest_bit - 6'd23),
        { Dummy_bit_exponent, Output_exponent } = (
            Computed_exponent < 9'b0_1000_0000 ? 9'b0_0000_0000 :
            Computed_exponent >= 9'b1_1000_0000 ? 9'b0_1111_1111 :
            Computed_exponent - 9'b0_1000_0000
        );

    assign out = { Output_sign, Output_exponent, Output_mantissa };
endmodule

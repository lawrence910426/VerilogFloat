module FLOAT_TO_INT_T();
    reg [31:0] value;
    wire [31:0] float;
    wire [31:0] out;

    INT_TO_FLOAT verified_chip (
        .in(value),
        .out(float)
    );

    FLOAT_TO_INT chip (
        .in(float),
        .out(out)
    );

    initial begin
        // Passed without deviation
        value = 32'hffff;
        #4;

        // Passed without deviation
        value = 32'h910426;
        #4;

        // Passed without deviation
        value = 32'h7122;
        #4;

        // Passed without deviation
        value = -32'h23;
        #4;
        
        // Passed with DEVIATION
        value = 32'd1073741824 + 1;
        #4;

        // Passed with DEVIATION
        value = -32'd1073741824 - 1;
        #4;

        $finish;
    end
    
endmodule

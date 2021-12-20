module FLOAT32_ADD_T();
    reg [31:0] a, b;
    wire [31:0] fa, fb;
    wire [31:0] fc, c, C;

    assign C = a + b;

    INT_TO_FLOAT 
        verified_in_a (
            .in(a), .out(fa)
        ),
        verified_in_b (
            .in(b), .out(fb)
        );

    FLOAT32_ADD chip (
        .a(fa), .b(fb),
        .out(fc)
    );

    FLOAT_TO_INT verified_out (
        .in(fc), .out(c)
    );

    initial begin
        // Test passed perfectly
        a = 32'd50;
        b = 32'd25;
        #4;

        // Test passed perfectly
        a = -32'd50;
        b = 32'd25;
        #4;

        // Test passed with round error
        a = 32'd0;
        b = 32'd25;
        #4;

        // Test passed perfectly
        a = -32'd50;
        b = 32'd75;
        #4;
        $finish;
    end
endmodule

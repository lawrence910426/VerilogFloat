module FLOAT32_MUL_T();
    reg [31:0] a, b, naked_fa, naked_fb;
    wire [31:0] fa, fb;
    wire [31:0] fc, c, C, naked_fc;

    assign C = a * b;

    INT_TO_FLOAT 
        verified_in_a (
            .in(a), .out(fa)
        ),
        verified_in_b (
            .in(b), .out(fb)
        );

    FLOAT32_MUL chip (
        .a(fa), .b(fb),
        .out(fc)
    );

    FLOAT_TO_INT verified_out (
        .in(fc), .out(c)
    );
    
    FLOAT32_MUL naked_chip (
        .a(naked_fa),
        .b(naked_fb),
        .out(naked_fc)
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

        // Test passed perfectly
        a = 32'd0;
        b = 32'd25;
        #4;

        // Test passed perfectly
        a = -32'd50;
        b = 32'd75;
        #4;
        
        naked_fa = 32'b0_10000000_10000000000000000000001;
        naked_fb = 32'b0_10000000_10000000000000000000000;
        #4;
        $finish;
    end
endmodule

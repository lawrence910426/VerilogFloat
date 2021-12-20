module INT_TO_FLOAT_T();
    reg [31:0] in;
    wire [31:0] out;
    INT_TO_FLOAT chip (
        .in(in),
        .out(out)
    );
    
    initial begin
        in = 32'd50;
        #4;
        in = 32'd1073741824 + 1;
        #4;
        in = -32'd1073741824;
        #4;
        in = 32'd1023;
        #4;
        in = -32'd1023;
        #4;
        
        $finish;
    end
    
endmodule

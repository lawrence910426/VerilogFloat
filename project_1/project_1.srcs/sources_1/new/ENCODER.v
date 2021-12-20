// ---------- 2^6 = 64 Encoder ------------
module ENCODER_64 (
    input [64 - 1:0] in,
    output [6 - 1:0] out
);
    wire [5 - 1:0] left, right;
    
    ENCODER_32 
        l (
            .in(in[63:32]),
            .out(left)
        ), 
        r (
            .in(in[31:0]),
            .out(right)
        );
    
    assign out = (
        in[63:32] > 0 ? 
        {1'b1, left} :
        {1'b0, right}
    );
endmodule

// ---------- 2^5 = 32 Encoder ------------
module ENCODER_32 (
    input [32 - 1:0] in,
    output [5 - 1:0] out
);
    wire [4 - 1:0] left, right;
    
    ENCODER_16
        l (
            .in(in[31:16]),
            .out(left)
        ), 
        r (
            .in(in[15:0]),
            .out(right)
        );
    
    assign out = (
        in[31:16] > 0 ? 
        {1'b1, left} :
        {1'b0, right}
    );
endmodule

// ---------- 2^4 = 16 Encoder ------------
module ENCODER_16 (
    input [16 - 1:0] in,
    output [4 - 1:0] out
);
    wire [3 - 1:0] left, right;
    
    ENCODER_8
        l (
            .in(in[15:8]),
            .out(left)
        ), 
        r (
            .in(in[7:0]),
            .out(right)
        );
    
    assign out = (
        in[15:8] > 0 ? 
        {1'b1, left} :
        {1'b0, right}
    );
endmodule

// ---------- 2^3 = 8 Encoder ------------
module ENCODER_8 (
    input [8 - 1:0] in,
    output [3 - 1:0] out
);
    wire [2 - 1:0] left, right;
    
    ENCODER_4 
        l (
            .in(in[7:4]),
            .out(left)
        ), 
        r (
            .in(in[3:0]),
            .out(right)
        );
    
    assign out = (
        in[7:4] > 0 ? 
        {1'b1, left} :
        {1'b0, right}
    );
endmodule

// ---------- 2^2 = 4 Encoder ------------
module ENCODER_4 (
    input [4 - 1:0] in,
    output [2 - 1:0] out
);
    wire [1 - 1:0] left, right;
    
    ENCODER_2 
        l (
            .in(in[3:2]),
            .out(left)
        ), 
        r (
            .in(in[1:0]),
            .out(right)
        );
    
    assign out = (
        in[3:2] > 0 ? 
        {1'b1, left} :
        {1'b0, right}
    );
endmodule

// ---------- 2^1 = 2 Encoder ------------
module ENCODER_2 (
    input [2 - 1:0] in,
    output [1 - 1:0] out
);
    assign out = (in[1] == 1'b1 ? 1'b1 : 1'b0);
endmodule
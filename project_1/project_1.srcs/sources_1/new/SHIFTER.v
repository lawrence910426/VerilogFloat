module SHIFTER(in, steps, out);
    parameter IN_SIZE = 23;
    
    input [IN_SIZE - 1:0] in;
    input [8 - 1:0] steps;
    output [IN_SIZE - 1:0] out;
    
    wire [IN_SIZE - 1:0] 
        _1, _2, _3, _4, _5, _6, _7, _8;
    
    assign 
        _1 = (in[7] ? 0 : in),
        _2 = (in[6] ? 0 : _1),
        _3 = (in[5] ? 0 : _2),
        _4 = (in[4] ? {16'b0000_0000_0000_0000, _3[IN_SIZE - 16 - 1:0]} : _3),
        _5 = (in[3] ? {8'b0000_0000, _4[IN_SIZE - 8 - 1:0]} : _4),
        _6 = (in[2] ? {4'b0000, _5[IN_SIZE - 4 - 1:0]} : _5),
        _7 = (in[1] ? {2'b00, _6[IN_SIZE - 2 - 1:0]} : _6),
        _8 = (in[0] ? {1'b0, _7[IN_SIZE - 1 - 1:0]} : _7),
        out = _8;
endmodule

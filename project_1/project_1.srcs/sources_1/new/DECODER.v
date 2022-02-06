module ENCODER (in, out);
    input [32 - 1:0] in;
    output reg [5 - 1:0] out;

    always @ (in) begin
        casex (in)
            32'b1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd31;
            32'b01x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd30;
            32'b001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd29;
            32'b0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd28;

            32'b0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd27;
            32'b0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd26;
            32'b0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd25;
            32'b0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd24;

            32'b0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd23;
            32'b0000_0000_01xx_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd22;
            32'b0000_0000_001x_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd21;
            32'b0000_0000_0001_xxxx_xxxx_xxxx_xxxx_xxxx: out = 5'd20;

            32'b0000_0000_0000_1xxx_xxxx_xxxx_xxxx_xxxx: out = 5'd19;
            32'b0000_0000_0000_01xx_xxxx_xxxx_xxxx_xxxx: out = 5'd18;
            32'b0000_0000_0000_001x_xxxx_xxxx_xxxx_xxxx: out = 5'd17;
            32'b0000_0000_0000_0001_xxxx_xxxx_xxxx_xxxx: out = 5'd16;

            // -----------------------------------------------------

            32'b0000_0000_0000_0000_1xxx_xxxx_xxxx_xxxx: out = 5'd15;
            32'b0000_0000_0000_0000_01xx_xxxx_xxxx_xxxx: out = 5'd14;
            32'b0000_0000_0000_0000_001x_xxxx_xxxx_xxxx: out = 5'd13;
            32'b0000_0000_0000_0000_0001_xxxx_xxxx_xxxx: out = 5'd12;

            32'b0000_0000_0000_0000_0000_1xxx_xxxx_xxxx: out = 5'd11;
            32'b0000_0000_0000_0000_0000_01xx_xxxx_xxxx: out = 5'd10;
            32'b0000_0000_0000_0000_0000_001x_xxxx_xxxx: out = 5'd09;
            32'b0000_0000_0000_0000_0000_0001_xxxx_xxxx: out = 5'd08;

            32'b0000_0000_0000_0000_0000_0000_1xxx_xxxx: out = 5'd07;
            32'b0000_0000_0000_0000_0000_0000_01xx_xxxx: out = 5'd06;
            32'b0000_0000_0000_0000_0000_0000_001x_xxxx: out = 5'd05;
            32'b0000_0000_0000_0000_0000_0000_0001_xxxx: out = 5'd04;

            32'b0000_0000_0000_0000_0000_0000_0000_1xxx: out = 5'd03;
            32'b0000_0000_0000_0000_0000_0000_0000_01xx: out = 5'd02;
            32'b0000_0000_0000_0000_0000_0000_0000_001x: out = 5'd01;
            32'b0000_0000_0000_0000_0000_0000_0000_0001: out = 5'd00;

        endcase
    end

endmodule


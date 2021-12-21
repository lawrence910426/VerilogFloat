# VerilogFloat
- The RTLs are [here](https://github.com/lawrence910426/VerilogFloat/tree/main/project_1/project_1.srcs/sources_1/new)
- Pure combinatorial circuit & Data flow modeling
- Vivado is recommended
- Loosely follow IEEE 756 floating point standard
  - +/- inf, 0 and NaN are not implemented
  - All modules are tested with limited cases
- If you find any bug and you have the time to fix it, please
  - Add another test case
  - Send a pull request
  - Do not modify module I/Os.

# Usage

## Conversion
```Verilog=
reg [31:0] value;
wire [31:0] float;
wire [31:0] out;

INT_TO_FLOAT to_float (
    .in(value),
    .out(float)
);

FLOAT_TO_INT to_int (
    .in(float),
    .out(out)
);
```

## Addition/Subtraction
```Verilog=
reg [31:0] a, b;
wire [31:0] fa, fb;
wire [31:0] fc, c;

INT_TO_FLOAT 
    to_float_a (
        .in(a), .out(fa)
    ),
    to_float_b (
        .in(b), .out(fb)
    );

FLOAT32_ADD addition (
    .a(fa), .b(fb),
    .out(fc)
);

FLOAT_TO_INT to_int (
    .in(fc), .out(c)
);
```

## Multiplication
```Verilog=
reg [31:0] a, b;
wire [31:0] fa, fb;
wire [31:0] fc, c;

INT_TO_FLOAT 
    to_float_a (
        .in(a), .out(fa)
    ),
    to_float_b (
        .in(b), .out(fb)
    );

FLOAT32_MUL addition (
    .a(fa), .b(fb),
    .out(fc)
);

FLOAT_TO_INT to_int (
    .in(fc), .out(c)
);
```

## Comparison
```Verilog=
reg [31:0] a, b;
wire [31:0] fa, fb;
wire [31:0] fc, c;

INT_TO_FLOAT 
    to_float_a (
        .in(a), .out(fa)
    ),
    to_float_b (
        .in(b), .out(fb)
    );

assign greater = (a > b ? a : b);
assign smaller = (a < b ? a : b);
```

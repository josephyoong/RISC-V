// MUX2
// 2 to 1 Multiplexer (MUX)

module MUX2 (
    input sel,
    input [31:0] I0,
    input [31:0] I1,
    output [31:0] O
);

assign O = control ? I1 : I0;

endmodule

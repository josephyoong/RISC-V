// MUX3
// 3 to 1 Multiplexer (MUX)
// sel cannot be 2'b11

module MUX3 (
    input [1:0] sel,
    input [31:0] I00,
    input [31:0] I01,
    input [31:0] I10,
    output [31:0] O
);

assign O = (control == 2'b00) ? I00 :
           (control == 2'b01) ? I01 :
                                I10;

endmodule
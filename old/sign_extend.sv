// sign_extend
// Sign Extend

module sign_extend (
    input [11:0] imm,
    output [31:0] sign_imm
);

assign sign_imm[11:0] = imm[11:0];
assign sign_imm[31:12] = {20{imm[15]}};

endmodule

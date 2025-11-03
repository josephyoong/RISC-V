// PC_branch
// Program Counter (PC) Branch 

module PC_branch (
    input [31:0] sign_imm,
    input [31:0] PC_plus4,
    output [31:0] PC_branch
);

wire [31:0] sign_imm_x4;

assign sign_imm_x4[31:2] = sign_imm[29:0];
assign sign_imm_x4[1:0] = 2'b00;

assign PC_branch = sign_imm_x4 + PC_plus4;

endmodule

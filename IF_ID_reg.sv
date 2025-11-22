//
//

module IF_ID_reg (
    input clk,
    input [31:0] instr_F,
    input [31:0] PC_plus4_F,
    output reg [31:0] instr_D,
    output reg [31:0] PC_plus4_D
);

initial begin
    instr_D = 0;
    PC_plus4_D = 0;
end

always @(posedge clk) begin
    instr_D <= instr_F;
    PC_plus4_D <= PC_plus4_F;
end

endmodule
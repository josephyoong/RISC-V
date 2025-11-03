// ALU
// (ALU)

module ALU (
    input [31:0] srcA,
    input [31:0] srcB,
    input [2:0] ALU_control,
    output reg [31:0] ALU_result,
    output zero // for >, if zero srcA = src B
);

parameter ADD = 3'b010;
parameter SUBTRACT = 3'b110;
parameter AND_OP = 3'b000;
parameter OR_OP = 3'b001;
parameter LESS_THAN = 3'b111;

always @(*) begin
    case (ALU_control)
    ADD: ALU_result = srcA + srcB;
    SUBTRACT: ALU_result = srcA - srcB;
    AND_OP: ALU_result = srcA & srcB;
    OR_OP: ALU_result = srcA | srcB;
    LESS_THAN: ALU_result = (srcA < srcB) ? 32'b1 : 32'b0;
    default: ALU_result = 32'b0;
    endcase
end

assign zero = (ALU_result == 32'b0);

endmodule

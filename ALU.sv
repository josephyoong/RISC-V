// ALU
// (ALU)

module ALU (
    input [31:0] srcA,
    input [31:0] srcB,
    input [3:0] ALU_control,
    output reg [31:0] ALU_result
);

parameter ADD = 4'b0010;
parameter SUBTRACT = 4'b0110;
parameter AND_OP = 4'b0000;
parameter OR_OP = 4'b0001;
parameter LESS_THAN = 4'b0111;

initial begin
    ALU_result = 0;
end

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

endmodule

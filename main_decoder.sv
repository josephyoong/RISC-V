//
//
//

module main_decoder (
    input [6:0] opcode,
    output reg ctrl_register_file_WE_D,
    output reg ctrl_srcB_D,
    output reg ctrl_register_file_WA_D,
    output reg ctrl_data_memory_WE_D,
    output reg ctrl_result_D,
    output reg [2:0] ctrl_ALU_op
);

reg [7:0] controls;

assign {ctrl_register_file_WE_D, ctrl_srcB_D, ctrl_register_file_WA_D, ctrl_data_memory_WE_D, ctrl_result_D, ctrl_ALU_op} = controls;

always @(*) begin
    case (opcode)
    7'b0110011: controls <= 8'b10100010; // R-TYPE      // alu op 010, R-type, see funct3 funct7
    endcase
    7'b0010011: controls <= 8'b11100001; // I-TYPE ALU  // alu op 001, 
    7'b0000011: ; // I-TYPE LOAD
    7'b0100011: ; // S-TYPE
    7'b1100011: ; // B-TYPE
end

endmodule
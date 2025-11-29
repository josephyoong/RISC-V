//
//
//
//
//

module control_unit (
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    output ctrl_register_file_WE_D,
    output ctrl_srcB_D,
    output ctrl_register_file_WA_D,
    output ctrl_data_memory_WE_D,
    output ctrl_result_D,
    output [3:0] ctrl_ALU_D,
    output branch,
    output [2:0] sel_imm
);

wire [2:0] ctrl_ALU_op;

main_decoder control_unit_main_decoder (
    .opcode(opcode),
    .ctrl_register_file_WE_D(ctrl_register_file_WE_D),
    .ctrl_srcB_D(ctrl_srcB_D),
    .ctrl_register_file_WA_D(ctrl_register_file_WA_D),
    .ctrl_data_memory_WE_D(ctrl_data_memory_WE_D),
    .ctrl_result_D(ctrl_result_D),
    .ctrl_ALU_op(ctrl_ALU_op)
);

ALU_decoder control_unit_ALU_decoder (
    .funct3(funct3),
    .funct7(funct7),
    .ctrl_ALU_op(ctrl_ALU_op),
    .ctrl_ALU(ctrl_ALU_D)
);

endmodule


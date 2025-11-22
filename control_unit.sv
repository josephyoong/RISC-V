//
//
//
//
//

module control_unit (
    input [6:0] opcode,
    output ctrl_register_file_WE_D,
    output ctrl_srcB_D,
    output ctrl_register_file_WA_D,
    output ctrl_data_memory_WE_D,
    output ctrl_result_D,
    output [2:0] ctrl_ALU_op_D
);

main_decoder control_unit_main_decoder (
    .opcode(opcode),
    .ctrl_register_file_WE_D(ctrl_register_file_WE_D),
    .ctrl_srcB_D(ctrl_srcB_D),
    .ctrl_register_file_WA_D(ctrl_register_file_WA_D),
    .ctrl_data_memory_WE_D(ctrl_data_memory_WE_D),
    .ctrl_result_D(ctrl_result_D),
    .ctrl_ALU_op_D(ctrl_ALU_op_D)
);

endmodule


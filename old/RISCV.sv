//
//
//
//
//

module RISCV (
    input clk,
    input rst
);

wire [31:0] PC;
wire [31:0] PC_next;
wire [31:0] PC_plus4_F;
wire [31:0] instr_F;
wire [31:0] instr_D;
wire [4:0]  register_file_WA;  
wire [31:0] result_W;             
wire [31:0] PC_plus4_D;
wire [31:0] srcA_D;
wire [31:0] register_file_srcB_D;
wire [31:0] sign_imm_D;
wire [31:0] srcA_E;
wire [31:0] register_file_srcB_E;
wire [31:0] PC_plus4_E;
wire [4:0]  rs2_E;
wire [4:0]  rd_E;
wire [31:0] sign_imm_E;
wire [31:0] srcA_reg_file_E;
wire [31:0] srcB_notsignimm_E;
wire [31:0] srcB;
wire [31:0] ALU_result_E;
wire        ALU_zero_E;
wire [4:0]  register_file_WA_E;
wire [31:0] PC_branch_E;
wire        ALU_zero_M;
wire [31:0] ALU_result_M;
wire [31:0] register_file_srcB_M;
wire [31:0] register_file_WA_M;
wire [31:0] PC_branch_M;
wire [31:0] data_memory_RD_M;
wire [31:0] ALU_resuhlt_W;
wire [4:0]  register_file_WA_W;
wire [31:0] data_memory_RD_W;

// - - - Control Signals - - -
// DECODE
wire ctrl_register_file_WE_D;                  
wire ctrl_srcB_D;
wire ctrl_register_file_WA_D;
wire [2:0] ctrl_ALU_D;
wire ctrl_data_memory_WE_D;
wire ctrl_result_D;
wire ctrl_PC_src_D;
wire ctrl_branch_D;
// EXECUTE
wire ctrl_register_file_WE_E;                  
wire ctrl_srcB_E;
wire ctrl_register_file_WA_E;
wire [2:0] ctrl_ALU_E;
wire ctrl_data_memory_WE_E;
wire ctrl_result_E;
wire ctrl_PC_src_E;
wire ctrl_branch_E;
// MEMORY
wire ctrl_register_file_WE_M;
wire ctrl_data_memory_WE_M;
wire ctrl_result_M;
wire ctrl_branch_M;
// WRITEBACK
wire ctrl_register_file_WE_W;
wire ctrl_result_W;

wire ctrl_PC_src_M = 0;

//
//
//
//
//
// * - - - FETCH - - - *
//
//
//
//
//
//
//
//

MUX2 RISCV_MUX2_PC_next (
    .sel(ctrl_PC_src_M),            // CONTROL FROM MEMORY
    .I0(PC_plus4_F),                    
    .I1(PC_branch_M),                   // FROM MEMORY
    .O(PC_next)                         // out
);

PC RISCV_PC (
    .clk(clk),
    .rst(rst),
    .PC_next(PC_next),
    .PC(PC)                             // out
);

instruction_memory RISCV_instruction_memory (
    .A(PC),
    .RD(instr_F)                        // out
);

PC_plus4 RISCV_PC_plus4 (
    .I(PC),
    .O(PC_plus4_F)                      // out
);

//
//
//
//
//
// * - - - DECODE - - - *
//
//
//
//
//
//
//
//

IF_ID_reg RISCV_IF_ID_reg (
    .clk(clk),
    // FROM FETCH
    .instr_F(instr_F),  
    .PC_plus4_F(PC_plus4_F),
    // TO DECODE
    .instr_D(instr_D),
    .PC_plus4_D(PC_plus4_D)
);

register_file RISCV_register_file (
    .clk(clk),
    .WE3(ctrl_register_file_WE_W),           // CONTROL FROM WRITEBACK
    .A1(instr_D[19:15]),  // rs1                  
    .A2(instr_D[24:20]),  // rs2         
    .A3(register_file_WA_W),            // FROM WRITEBACK
    .WD3(result_W),                     // FROM WRITEBACK
    .RD1(srcA_D),                       // out
    .RD2(register_file_srcB_D)          // out
);

sign_extend RISCV_sign_extend (
    .imm(instr_D[31:20]),                 
    .sign_imm(sign_imm_D)               // out
);

// CONTROL UNIT
control_unit RISCV_control_unit (
    .opcode(instr_D[6:0]),
    .ctrl_register_file_WE_D(ctrl_register_file_WE_D),
    .ctrl_srcB_D(ctrl_srcB_D),
    .ctrl_register_file_WA_D(ctrl_register_file_WA_D),
    .ctrl_data_memory_WE_D(ctrl_data_memory_WE_D),
    .ctrl_result_D(ctrl_result_D),
    .ctrl_ALU_D(ctrl_ALU_D)
);

//
//
//
//
//
// * - - - EXECUTE - - - *
//
//
//
//
//
//
//
//

ID_IE_reg RISCV_ID_IE_reg (
    .clk(clk),
    // FROM DECODE
    .srcA_D(srcA_D),
    .register_file_srcB_D(register_file_srcB_D),
    .rs2_D(instr_D[24:20]),    
    .rd_D(instr_D[11:7]),   
    .sign_imm_D(sign_imm_D), 
    .PC_plus4_D(PC_plus4_D),  
    .ctrl_register_file_WE_D(ctrl_register_file_WE_D),
    .ctrl_srcB_D(ctrl_srcB_D),
    .ctrl_register_file_WA_D(ctrl_register_file_WA_D),
    .ctrl_data_memory_WE_D(ctrl_data_memory_WE_D),
    .ctrl_result_D(ctrl_result_D),
    .ctrl_branch_D(ctrl_branch_D),
    .ctrl_ALU_D(ctrl_ALU_D),
    // TO EXECUTE   
    .srcA_E(srcA_reg_file_E),
    .register_file_srcB_E(register_file_srcB_E),
    .rs2_E(rs2_E),
    .rd_E(rd_E),
    .sign_imm_E(sign_imm_E),
    .PC_plus4_E(PC_plus4_E),
    .ctrl_register_file_WE_E(ctrl_register_file_WE_E),
    .ctrl_srcB_E(ctrl_srcB_E),
    .ctrl_register_file_WA_E(ctrl_register_file_WA_E),
    .ctrl_data_memory_WE_E(ctrl_data_memory_WE_E),
    .ctrl_result_E(ctrl_result_E),
    .ctrl_branch_E(ctrl_branch_E),
    .ctrl_ALU_E(ctrl_ALU_E)
);

MUX2 RISCV_MUX2_register_file_WA (
    .sel(ctrl_register_file_WA_E),    // CONTROL
    .I0(rs2_E),
    .I1(rd_E),
    .O(register_file_WA_E)              // out
);

MUX3 RISCV_MUX3_srcA (
    sel(),                          // CONTROL
    I00(srcA_reg_file_E),
    I01(result_W),
    I10(ALU_result_M),
    O(srcA_E)
);

MUX3 RISCV_MUX3_srcB_notsignimm (
    sel(),                          // CONTROL
    I00(register_file_srcB_E),
    I01(result_W),
    I10(ALU_result_M),
    O(srcB_notsignimm_E)
);

MUX2 RISCV_MUX2_SrcB (
    .sel(ctrl_srcB_E),              // CONTROL
    .I0(srcB_notsignimm_E),
    .I1(sign_imm_E),
    .O(srcB)                            // out
);

ALU RISCV_ALU (
    .srcA(srcA_E),
    .srcB(srcB),
    .ALU_control(ctrl_ALU_E),          // CONTROL
    .ALU_result(ALU_result_E),          // out
    .zero(ALU_zero_E)                   // out
);

PC_branch RISCV_PC_branch (
    .sign_imm(sign_imm_E),
    .PC_plus4(PC_plus4_E),
    .PC_branch(PC_branch_E)
);

//
//
//
//
//
// * - - - MEMORY - - - *
//
//
//
//
//
//
//
//

IE_IM_reg RISCV_IE_IM_reg (
    .clk(clk),
    // FROM EXECUTE
    .ALU_zero_E(ALU_zero_E),
    .ALU_result_E(ALU_result_E),
    .register_file_srcB_E(register_file_srcB_E),
    .register_file_WA_E(register_file_WA_E),
    .PC_branch_E(PC_branch_E),
    .ctrl_register_file_WE_E(ctrl_register_file_WE_E),
    .ctrl_data_memory_WE_E(ctrl_data_memory_WE_E),
    .ctrl_result_E(ctrl_result_E),
    // TO MEMORY
    .ALU_zero_M(ALU_zero_M),
    .ALU_result_M(ALU_result_M),
    .register_file_srcB_M(register_file_srcB_M),
    .register_file_WA_M(register_file_WA_M),
    .PC_branch_M(PC_branch_M),
    .ctrl_register_file_WE_M(ctrl_register_file_WE_M),
    .ctrl_data_memory_WE_M(ctrl_data_memory_WE_M),
    .ctrl_result_M(ctrl_result_M)
);

data_memory #(.DATA_MEMORY_DEPTH(256)) RISCV_data_memory (
    .clk(clk),
    .WE(ctrl_data_memory_WE_M),           // CONTROL
    .WD(register_file_srcB_M),
    .A(ALU_result_M),
    .RD(data_memory_RD_M)               // out
);

//
//
//
//
//
// * - - - WRITEBACK - - - *
//
//
//
//
//
//
//
//

IM_IW_reg RISCV_IM_IW_reg (
    .clk(clk),
    // FROM MEMORY
    .ALU_result_M(ALU_result_M),
    .register_file_WA_M(register_file_WA_M),
    .data_memory_RD_M(data_memory_RD_M),
    .ctrl_register_file_WE_M(ctrl_register_file_WE_M),
    .ctrl_result_M(ctrl_result_M),
    // TO WRITEBACK
    .ALU_result_W(ALU_result_W),
    .register_file_WE_W(register_file_WE_W),
    .data_memory_RD_W(data_memory_RD_W),
    .ctrl_register_file_WA_W(ctrl_register_file_WA_W),
    .ctrl_result_W(ctrl_result_W)
);

MUX2 RISCV_MUX2_result (
    .sel(ctrl_result_W),            // CONTROL
    .I0(ALU_result_W),
    .I1(data_memory_RD_W),
    .O(result_W)                        // out
);

endmodule
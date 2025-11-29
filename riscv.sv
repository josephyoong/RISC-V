//

module riscv (
    input clk
);

wire [31:0] instr_F;
wire [31:0] PC_plus4_F;

wire [31:0] s1_D;
wire [31:0] s2_D;
wire [4:0] rd_D;
wire [4:0] rs1_D;
wire [4:0] rs2_D;
wire [31:0] sign_imm_D;
wire [31:0] PC_branch_D;
wire register_file_wr_en_D;
wire data_memory_wr_en_D;
wire [2:0] ALU_ctrl_D;
wire sel_srcB_D;
wire sel_register_file_wr_addr_D;
wire sel_result_D;
wire branch_D;

wire [4:0] register_file_wr_addr_E;
wire [31:0] ALU_output_E;
wire [31:0] wr_data_E;
wire register_file_wr_en_E;
wire data_memory_wr_en_E;
wire sel_result_E;

wire [31:0] ALU_output_M;
wire [4:0] register_file_wr_addr_M;
wire [31:0] rd_data_M;
wire register_file_wr_en_M;
wire sel_result_M;

wire [31:0] result_W;
wire register_file_wr_en_W;
wire [4:0] register_file_wr_addr_W;

fetch riscv_fetch (
    .clk(clk),
    .rst(),
    .i_en(),    // hazard
    .i_sel_PC_D(),  // and gate
    .i_PC_branch_D(PC_branch_D),    
    .o_instr_F(instr_F),
    .o_PC_plus4_F(PC_plus4_F)
);

decode riscv_decode (
    .clk(clk),
    .clr(), // and gate
    .i_en(),    // hazard
    .i_instr_F(instr_F),
    .i_PC_plus4_F(PC_plus4_F),
    .i_register_file_wr_en_W(register_file_wr_en_W),
    .i_register_file_wr_addr_W(register_file_wr_addr_W)
    .i_result_W(result_W),
    .i_fwdA_D(),    // hazard
    .i_fwdB_D(),    // hazard
    .i_imm_sel_D(), // hazard
    .o_s1_D(s1_D),
    .o_s2_D(s2_D),
    .o_rd_D(rd_D),
    .o_rs1_D(rs1_D),
    .o_rs2_D(rs2_D),
    .o_sign_imm_D(sign_imm_D),
    .o_PC_branch_D(PC_branch_D),
    .o_register_file_wr_en_D(register_file_wr_en_D),
    .o_data_memory_wr_en_D(data_memory_wr_en_D),
    .o_ALU_ctrl_D(ALU_ctrl_D),
    .o_sel_srcB_D(sel_srcB_D),
    .o_sel_register_file_wr_addr_D(sel_register_file_wr_addr_D),
    .o_sel_result_D(sel_result_D),
    .o_branch_D(branch_D)
);

execute fetch_execute (
    .clk(clk),
    .clr(), // hazard
    .i_s1_D(s1_D),
    .i_s2_D(s2_D),
    .i_rd_D(rd_D),
    .i_rs1_D(rs1_D),
    .i_rs2_D(rs2_D),
    .i_sign_imm_D(sign_imm_D),
    .i_register_file_wr_en_D(register_file_wr_en_D),
    .i_data_memory_wr_en_D(data_memory_wr_en_D),
    .i_ALU_ctrl_D(ALU_ctrl_D),
    .i_sel_srcB_D(sel_srcB_D),
    .i_sel_register_file_wr_addr_D(sel_register_file_wr_addr_D),
    .i_sel_result_D(sel_result_D),
    .i_branch_D(branch_D),
    .i_ALU_output_M(ALU_output_M),
    .i_result_W(result_W),
    .i_fwdA_E(),    // hazard
    .i_fwdB_E(),    // hazard
    .o_register_file_wr_addr_E(register_file_wr_addr_E),
    .o_ALU_output_E(ALU_output_E),
    .o_wr_data_E(wr_data_E),
    .o_register_file_wr_en_E(register_file_wr_en_E),
    .o_data_memory_wr_en_E(data_memory_wr_en_E),
    .o_sel_result_E(sel_result_E),
    .o_rs1_E(), // hazard
    .o_rs2_E()  // hazard
);

memory riscv_memory (
    .clk(clk),
    .i_register_file_wr_addr_E(register_file_wr_addr_E),
    .i_ALU_output_E(ALU_output_E),
    .i_wr_data_E(wr_data_E),
    .i_register_file_wr_en_E(register_file_wr_en_E),
    .i_data_memory_wr_en_E(data_memory_wr_en_E),
    .i_sel_result_E(sel_result_E),
    .o_ALU_output_M(ALU_output_M),
    .o_register_file_wr_addr_M(register_file_wr_addr_M),
    .o_rd_data_M(rd_data_M),
    .o_register_file_wr_en_M(register_file_wr_en_M),
    .o_sel_result_M(sel_result_M)
);

writeback riscv_writeback (
    .clk(clk),
    .i_ALU_output_M(ALU_output_M),
    .i_register_file_wr_addr_M(register_file_wr_addr_M),
    .i_rd_data_M(rd_data_M),
    .i_register_file_wr_en_M(register_file_wr_en_M),
    .i_sel_result_M(sel_result_M),
    .o_result_W(result_W),
    .o_register_file_wr_en_W(register_file_wr_en_W),
    .o_register_file_wr_addr_W(register_file_wr_addr_W)
);


endmodule
//
//

module ID_IE_reg (
    input clk,
    input [31:0] srcA_D,
    input [31:0] register_file_srcB_D,
    input [4:0] rs2_D,
    input [4:0] rd_D,
    input [31:0] sign_imm_D,
    input [31:0] PC_plus4_D,
    input ctrl_register_file_WE_D,
    input ctrl_srcB_D,
    input ctrl_register_file_WA_D,
    input ctrl_data_memory_WE_D,
    input ctrl_result_D,
    input ctrl_branch_D,
    input [2:0] ctrl_ALU_op_D,
    output reg [31:0] srcA_E,
    output reg [31:0] register_file_srcB_E,
    output reg [4:0] rs2_E,
    output reg [4:0] rd_E,
    output reg [31:0] sign_imm_E,
    output reg [31:0] PC_plus4_E,
    output reg ctrl_register_file_WE_E,
    output reg ctrl_srcB_E,
    output reg ctrl_register_file_WA_E,
    output reg ctrl_data_memory_WE_E,
    output reg ctrl_result_E,
    output reg ctrl_branch_E,
    output reg [2:0] ctrl_ALU_op_D,
);

always @(posedge clk) begin
    srcA_E <= srcA_D;
    register_file_srcB_E <= register_file_srcB_D;
    rs2_E <= rs2_D;
    rd_E <= rd_D;
    sign_imm_E <= sign_imm_D;
    PC_plus4_E <= PC_plus4_D;
    ctrl_register_file_WE_E <= ctrl_register_file_WE_D;
    ctrl_srcB_E <= ctrl_srcB_D;
    ctrl_register_file_WA_E <= ctrl_register_file_WA_D;
    ctrl_data_memory_WE_E <= ctrl_data_memory_WE_D;
    ctrl_result_E <= ctrl_result_D;
    ctrl_branch_E <= ctrl_branch_D;
    ctrl_ALU_op_E <= ctrl_ALU_op_D;
end

endmodule
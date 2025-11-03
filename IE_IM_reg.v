//
//

module IE_IM_reg (
    input clk,
    input ALU_zero_E,
    input [31:0] ALU_result_E,
    input [31:0] register_file_srcB_E,
    input [4:0] register_file_WA_E,
    input [31:0] PC_branch_E,
    input ctrl_register_file_WE_E,
    input ctrl_data_memory_WE_E,
    input ctrl_result_E,
    output reg ALU_zero_M,
    output reg [31:0] ALU_result_M,
    output reg [31:0] register_file_srcB_M,
    output reg [4:0] register_file_WA_M,
    output reg [31:0] PC_branch_M,
    output reg ctrl_register_file_WE_M,
    output reg ctrl_data_memory_WE_M,
    output reg ctrl_result_M
);

always @(posedge clk) begin
    ALU_zero_M <= ALU_zero_E;
    ALU_result_M <= ALU_result_E;
    register_file_srcB_M <= register_file_srcB_E;
    register_file_WA_M <= register_file_WA_E;
    PC_branch_M <= PC_branch_E;
    ctrl_register_file_WE_M <= ctrl_register_file_WE_E;
    ctrl_data_memory_WE_M <= ctrl_data_memory_WE_E;
    ctrl_result_M <= ctrl_result_E;
end

endmodule
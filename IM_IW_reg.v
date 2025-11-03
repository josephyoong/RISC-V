//
//

module IM_IW_reg (
    input clk,
    input [31:0] ALU_result_M,
    input [31:0] register_file_WA_M,
    input [31:0] data_memory_RD_M,
    input ctrl_register_file_WE_M,
    input ctrl_result_M,
    output reg [31:0] ALU_result_W,
    output reg [4:0] register_file_WA_W,
    output reg [31:0] data_memory_RD_W,
    output reg ctrl_register_file_WE_W,
    output reg ctrl_result_W
);

always @(posedge clk) begin
    ALU_result_W <= ALU_result_M;
    register_file_WA_W <= register_file_WA_M;
    data_memory_RD_W <= data_memory_RD_M;
    ctrl_register_file_WE_W <= ctrl_register_file_WE_M;
    ctrl_result_W <= ctrl_result_M;
end

endmodule
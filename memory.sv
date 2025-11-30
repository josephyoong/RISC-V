// memory

module memory (
    input clk,

    input [4:0]    i_register_file_wr_addr_E,
    input [31:0]   i_ALU_output_E,
    input [31:0]   i_wr_data_E,

    input          i_register_file_wr_en_E,
    input          i_data_memory_wr_en_E,
    input          i_sel_result_E,

    output [31:0]  o_ALU_output_M,
    output [4:0]   o_register_file_wr_addr_M,
    output [31:0]  o_rd_data_M,

    output         o_register_file_wr_en_M,
    output         o_sel_result_M,
    output         o_data_memory_wr_en_M
);

// registers
reg        register_file_wr_en;
reg        data_memory_wr_en;
reg        sel_result;

reg [4:0]  register_file_wr_addr;
reg [31:0] ALU_output;
reg [31:0] wr_data;

always @(posedge clk) begin
    register_file_wr_en <= i_register_file_wr_en_E;
    data_memory_wr_en <= i_data_memory_wr_en_E;
    sel_result <= i_sel_result_E;
    register_file_wr_addr <= i_register_file_wr_addr_E;
    ALU_output <= i_ALU_output_E;
    wr_data <= i_wr_data_E;
end

// data memory
data_memory memory_data_memory (
    .clk(clk),
    .WE(data_memory_wr_en),     
    .WD(wr_data),
    .A(ALU_output),
    .RD(o_rd_data_M) 
);

// assign outputs
assign o_ALU_output_M = ALU_output;
assign o_register_file_wr_addr_M = register_file_wr_addr;
assign o_register_file_wr_en_M = register_file_wr_en;
assign o_sel_result_M = sel_result;
assign o_data_memory_wr_en_M = data_memory_wr_en;

endmodule
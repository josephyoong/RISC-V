// writeback

module writeback (
    input clk,

    input [31:0]  i_ALU_output_M,
    input [4:0]   i_register_file_wr_addr_M
    input [31:0]  i_rd_data_M,

    input         i_register_file_wr_en_M,
    input         i_sel_result_M,

    output        o_result_W,

    output        o_register_file_wr_en_W,
    output [4:0]  o_register_file_wr_addr_W
);

// registers
reg [31:0]  ALU_output;
reg [4:0]   register_file_wr_addr;
reg [31:0]  rd_data;
reg         register_file_wr_en;
reg         sel_result;

always @(posedge clk) begin
    ALU_output = i_ALU_output_M;
    register_file_wr_addr = i_register_file_wr_addr_M;
    rd_data = i_rd_data_M;
    register_file_wr_en = i_register_file_wr_en_M;
    sel_result = i_sel_result_M;
end

// MUX result is from data memory or ALU output
assign o_result_W = sel_result ? rd_data : ALU_output;

// assign outputs
assign o_register_file_wr_en_W = register_file_wr_en;
assign o_register_file_wr_addr_W = register_file_wr_addr;

endmodule
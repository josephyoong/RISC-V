// execute

module execute (
    input clk,
    input clr,

    input [31:0]   i_s1_D,
    input [31:0]   i_s2_D,
    
    input [4:0]    i_rd_D,
    input [4:0]    i_rs1_D,
    input [4:0]    i_rs2_D,

    input [31:0]   i_sign_imm_D,

    input           i_register_file_wr_en_D,
    input           i_data_memory_wr_en_D,
    input [3:0]     i_ALU_ctrl_D,
    input           i_sel_srcB_D,
    input           i_sel_register_file_wr_addr_D,
    input           i_sel_result_D,
    input           i_branch_D,

    input [31:0]    i_ALU_output_M,
    input [31:0]    i_result_W,

    input [1:0]     i_fwdA_E,
    input [1:0]     i_fwdB_E,

    output [4:0]    o_register_file_wr_addr_E,
    output [31:0]   o_ALU_output_E,
    output [31:0]   o_wr_data_E

    output          o_register_file_wr_en_E,
    output          o_data_memory_wr_en_E,
    output          o_sel_result_E,

    output [4:0]    o_rs1_E,
    output [4:0]    o_rs2_E
);

wire [31:0] srcA;
wire [31:0] wr_data;
wire [31:0] srcB;

// registers
reg [31:0]   s1;
reg [31:0]   s2;
    
reg [4:0]    rd;
reg [4:0]    rs1;
reg [4:0]    rs2;

reg [31:0]   sign_imm_I;
reg [31:0]   sign_imm_S;
reg [31:0]   sign_imm_B;
reg [31:0]   sign_imm_U;
reg [31:0]   sign_imm_J;

reg           register_file_wr_en;
reg           data_memory_wr_en;
reg [3:0]     ALU_ctrl;
reg           sel_srcB;
reg           sel_register_file_wr_addr;
reg           sel_result;
reg           branch;

always @(posedge clk) begin
    if (clr) begin
        
    end
    else begin
        s1 <= i_s1_D;
        s2 <= i_s2_D;
    
        rd <= i_rd_D;
        rs1 <= i_rs1_D;
        rs2 <= i_rs2_D;

        sign_imm <= i_sign_imm_I_D;

        register_file_wr_en <= i_register_file_wr_en_D;
        data_memory_wr_en <= i_data_memory_wr_en_D;
        ALU_ctrl <= i_ALU_ctrl_D;
        sel_srcB <= i_sel_srcB_D;
        sel_register_file_wr_addr <= i_sel_register_file_wr_addr_D;
        sel_result <= i_sel_result_D;
        branch <= i_branch_D;
    end
end

// MUX register file wr addr is either rd or rs2
assign o_register_file_wr_addr_E = sel_register_file_wr_addr ? rs2 : rd;

// MUX ALU srcA is either s1, previous ALU output, or previous data memory/ALU result
assign srcA = (i_fwdA_E == 2'b00) ? s1 : (i_fwdA_E == 2'b01) ? i_result_W : i_ALU_output_M;

// MUX ALU srcB is either s2, previous ALU output, or previous data memory/ALU result
assign wr_data = (i_fwdB_E == 2'b00) ? s2 : (i_fwdB_E == 2'b01) ? i_result_W : i_ALU_output_M;

// MUX ALU srcB is either wr_data or imm
assign srcB = sel_srcB ? sign_imm : wr_data;

// ALU
ALU execute_ALU (
    .srcA(srcA),
    .srcB(srcB),
    .ALU_control(ALU_ctrl),       
    .ALU_result(o_ALU_output_E)
);

// assign outputs
assign o_wr_data_E = wr_data;
assign o_register_file_wr_en_E = register_file_wr_en;
assign o_data_memory_wr_en_E = data_memory_wr_en;
assign o_sel_result_E = sel_result;
assign o_rs1_E = rs1;
assign o_rs2_E = rs2;

endmodule
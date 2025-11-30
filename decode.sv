// decode

module decode (
    input           clk,
    input           clr,

    input           i_en,

    input [31:0]    i_instr_F,
    input [31:0]    i_PC_plus4_F,

    input           i_register_file_wr_en_W,
    input [4:0]     i_register_file_wr_addr_W,
    input [31:0]    i_result_W,

    input [31:0]    i_ALU_output_M,

    input           i_fwdA_D,  
    input           i_fwdB_D,  

    output [31:0]   o_s1_D,
    output [31:0]   o_s2_D,

    output [4:0]    o_rd_D,
    output [4:0]    o_rs1_D,
    output [4:0]    o_rs2_D,

    output reg [31:0]   o_sign_imm_D,

    output [31:0]   o_PC_branch_D,

    output          o_equal_D,

    output          o_register_file_wr_en_D,
    output          o_data_memory_wr_en_D,
    output [3:0]    o_ALU_ctrl_D,
    output          o_sel_srcB_D,
    output          o_sel_register_file_wr_addr_D,
    output          o_sel_result_D,
    output          o_branch_D
);

// instr
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;
// register file 
wire [31:0] s1;
wire [31:0] s2;
// sign imm
wire [31:0] sign_imm_I;
wire [31:0] sign_imm_S;
wire [31:0] sign_imm_B;
wire [31:0] sign_imm_U;
wire [31:0] sign_imm_J;
wire [2:0]  sel_imm;
// equality
wire [31:0] eqA;
wire [31:0] eqB;

// registers
reg [31:0] instr;
reg [31:0] PC_plus4;

always @(posedge clk) begin
    if (clr) begin
        instr <= 0;
        PC_plus4 <= 0;
    end
    else if (i_en) begin
        instr <= i_instr_F;
        PC_plus4 <= i_PC_plus4_F;
    end
end

// decode instruction
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign rd  = instr[11:7];
assign opcode = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];

// sign extend imm
assign sign_imm_I = {{20{instr[31]}}, instr[31:20]};
assign sign_imm_S = {{20{instr[31]}} ,instr[31:25], instr[11:7]};
assign sign_imm_B = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
assign sign_imm_U = {instr[31:12], {12{1'b0}}};
assign sign_imm_J = {{11{instr[31]}} ,instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

// read from registers and write to registers
register_file decode_register_file (
    .clk(clk),
    .i_rd_addr1(rs1),
    .i_rd_addr2(rs2),
    .i_wr_en(i_register_file_wr_en_W),
    .i_wr_addr(i_register_file_wr_addr_W),
    .i_wr_data(i_result_W),
    .o_rd_data1(s1),
    .o_rd_data2(s2)
);
assign o_s1_D = s1;
assign o_s2_D = s2;

// MUX input to equal comparator is s or ALU result forwarded 
assign eqA = i_fwdA_D ? i_ALU_output_M : s1;
assign eqB = i_fwdB_D ? i_ALU_output_M : s2;
assign o_equal_D = (eqA == eqB);

// compute branch PC
assign o_PC_branch_D = PC_plus4 + sign_imm_B;

// assign outputs
assign o_rd_D  = rd;
assign o_rs1_D = rs1;
assign o_rs2_D = rs2;

// generate control signals from instr
control_unit decode_control_unit (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),

    .ctrl_register_file_WE_D(o_register_file_wr_en_D),
    .ctrl_srcB_D(o_sel_srcB_D),
    .ctrl_register_file_WA_D(o_sel_register_file_wr_addr_D),
    .ctrl_data_memory_WE_D(o_data_memory_wr_en_D),
    .ctrl_result_D(o_sel_result_D),
    .ctrl_ALU_D(o_ALU_ctrl_D),
    .branch(o_branch_D),
    .sel_imm(sel_imm)
);

// MUX select imm depending on instr type
always @(*) begin
    case (sel_imm)
        3'b000: o_sign_imm_D = sign_imm_I;
        3'b001: o_sign_imm_D = sign_imm_S;
        3'b010: o_sign_imm_D = sign_imm_B;
        3'b011: o_sign_imm_D = sign_imm_U;
        3'b100: o_sign_imm_D = sign_imm_J;
    endcase
end

endmodule
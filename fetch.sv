// fetch

module fetch (
    input           clk,
    input           rst,

    input           i_en,
    input           i_sel_PC_D,
    input [31:0]    i_PC_branch_D,    

    output [31:0]   o_instr_F,
    output [31:0]   o_PC_plus4_F
);

wire [31:0] PC_next;
wire [31:0] PC;
wire [31:0] PC_plus4;

assign PC_plus4 = PC + 4;
assign o_PC_plus4_F = PC_plus4;

// next PC is branch or plus 4
assign PC_next = i_sel_PC_D ? i_PC_branch_D : PC_plus4;

// program counter takes next value on clock edge if not stalled
always @(posedge clk) begin
    if (rst) begin
        o_PC <= 32'h00000000;
    end
    else if (i_en) begin
        PC <= PC_next;
    end
end

// read the instruction at program count address
instruction_memory fetch_instruction_memory (
    .i_rd_addr(PC),
    .o_rd_data(o_instr_F) 
);

endmodule
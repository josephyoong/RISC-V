// instruction_memory
// Instruction Memory

module instruction_memory (
    input [31:0] i_rd_addr,
    output [31:0] o_rd_data
);

reg [31:0] r_instruction [0:31];

assign o_rd_data = r_instruction[i_rd_addr[4:0]];

initial begin
    r_instruction[0]  = 32'h02328020; // add $s0, $s1, $s2 => rs=$s1(17) rt=$s2(18) rd=$s0(16) 
    r_instruction[1]  = 32'h00000000;
    r_instruction[2]  = 32'h00000000;
    r_instruction[3]  = 32'h00000000;
    r_instruction[4]  = 32'h00000000;
    r_instruction[5]  = 32'h00000000;
    r_instruction[6]  = 32'h00000000;
    r_instruction[7]  = 32'h00000000;
    r_instruction[8]  = 32'h00000000;
    r_instruction[9]  = 32'h00000000;
    r_instruction[10] = 32'h00000000;
    r_instruction[11] = 32'h00000000;
    r_instruction[12] = 32'h00000000;
    r_instruction[13] = 32'h00000000;
    r_instruction[14] = 32'h00000000;
    r_instruction[15] = 32'h00000000;
    r_instruction[16] = 32'h00000000;
    r_instruction[17] = 32'h00000000;
    r_instruction[18] = 32'h00000000;
    r_instruction[19] = 32'h00000000;
    r_instruction[20] = 32'h00000000;
    r_instruction[21] = 32'h00000000;
    r_instruction[22] = 32'h00000000;
    r_instruction[23] = 32'h00000000;
    r_instruction[24] = 32'h00000000;
    r_instruction[25] = 32'h00000000;
    r_instruction[26] = 32'h00000000;
    r_instruction[27] = 32'h00000000;
    r_instruction[28] = 32'h00000000;
    r_instruction[29] = 32'h00000000;
    r_instruction[30] = 32'h00000000;
    r_instruction[31] = 32'h00000000;
end

endmodule

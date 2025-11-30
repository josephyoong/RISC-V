// hazard unit

module hazard_unit (
    input i_branch_D,
    input [4:0] i_rs1_D,
    input [4:0] i_rs2_D,
    input [4:0] i_rs1_E,
    input [4:0] i_rs2_E,
    input [4:0] i_rd_E,
    input i_register_file_wr_en_E,
    input i_register_file_wr_en_M,
    input i_register_file_wr_en_W,
    input i_data_memory_wr_en_E,
    input i_data_memory_wr_en_M,
    input [4:0] i_register_file_wr_addr_E,
    input [4:0] i_register_file_wr_addr_M,
    input [4:0] i_register_file_wr_addr_W,
    input i_sel_result_E,
    input i_sel_result_M,

    output o_stall_F,
    output o_stall_D,
    output o_fwdA_D,
    output o_fwdB_D,
    output o_flush_E,
    output reg [1:0] o_fwdA_E,
    output reg [1:0] o_fwdB_E
);

reg lw_stall;
wire branch_stall;

//
// Forwarding to the execute stage
// 
// There is an instr which writes to reg. There is a subsequent instr which reads this reg in the 
// time period before the reg has been written to. For this subsequent instr to compute the 
// correct ALU output in the execution stage, the inputs (srcA and srcB) to the ALU must be 
// correct. Since these inputs are not yet written to the reg, they must come from either the 
// memory stage or writeback stage. Therefore, there are two cases for forwarding to the execute:
//
// 1)   Forwarding from the memory stage to the execute stage.
//      The destination reg for the ALU result from the instr in the memory stage is the same as 
//      one of the source reg for the ALU input in the execute stage. This requires the ALU output
//      for that instr in the memory stage to be the final result of this instr. The only case in
//      which this is not true is for instr which get their result from data memory (using the ALU
//      output as an intermediary addr result), so we must not forward that ALU output. For those 
//      cases, stalling is used.
// 2)   Fowarding from the writeback stage to the execute stage.
//      The destination reg for the result in the writeback stage is the same as one of the source
//      reg for the ALU input in the execute stage. We forward the writeback result to the execute
//      stage.
//
// forwarding srcA 
always @(*) begin
    // forward from memory to execute
    if  (i_register_file_wr_en_M &&                  // writing to register file
        (i_register_file_wr_addr_M == i_rs1_E) &&    // wr reg matches source reg
        (i_rs1_E != 0) &&                            // source reg is not $s(0)
        !i_sel_result_M)                             // ALU output is instr final result
        o_fwdA_E = 2'b10;
    // forward from writeback to execute
    else if (i_register_file_wr_en_W &&                 // writing to register file
            (i_register_file_wr_addr_W == i_rs1_E) &&   // wr reg matches source reg
            (i_rs1_E != 0))                             // source reg is not $s(0)
            o_fwdA_E = 2'b01;
    else 
        o_fwdA_E = 2'b00;
end
// forwarding srcB
always @(*) begin
    // forward from memory to execute
    if  (i_register_file_wr_en_M &&                  // writing to register file
        (i_register_file_wr_addr_M == i_rs2_E) &&    // wr reg matches source reg
        (i_rs2_E != 0) &&                            // source reg is not $s(0)
        !i_sel_result_M)                             // ALU output is instr final result
        o_fwdB_E = 2'b10;
    // forward from writeback to execute
    else if (i_register_file_wr_en_W &&                 // writing to register file
            (i_register_file_wr_addr_W == i_rs2_E) &&   // wr reg matches source reg
            (i_rs2_E != 0))                             // source reg is not $s(0)
            o_fwdB_E = 2'b01;
    else 
        o_fwdB_E = 2'b00;
end

//
// Stalling
//
// 
// 
// 
// stalling 
always @(*) begin
    if (i_sel_result_E &&                                   // if the result from ALU is for a lw (needs to go through memory)
        ((i_rs1_D == i_rd_E) || (i_rs2_D == i_rd_E)) &&     // and this lw would write to one of the registers needed by next instr
        (i_rd_E != 0)) begin                                // and desitination is not hardcoded 0 reg
            lw_stall = 1;                                   
        end   
    else begin
        lw_stall = 0;                                       
    end
end

//
// Branching
//
// if source reg for branch comparator in decode stage has RAW hazard, the source data must be forwarded from a later stage
// equal & branch is connected to deocde stage clr so dont need to worry about flushing mispredicted rn
// 
//
// forwarding for branching from memory to decode (comparator)
assign o_fwdA_D =   (i_rs1_D != 0) &&                           // not $s(0)
                    (i_rs1_D == i_register_file_wr_addr_M) &&   // matching reg
                    (i_register_file_wr_en_M) &&                // will write to reg
                    (!i_sel_result_M);                          // is the instr final result (not coming from data)

assign o_fwdB_D =   (i_rs2_D != 0) &&
                    (i_rs2_D == i_register_file_wr_addr_M) &&
                    (i_register_file_wr_en_M) &&
                    (!i_sel_result_M);

// stalling for branching if want to forward from execute to decode (comparator)
assign branch_stall =   ((i_branch_D) &&                    // if your instr in decode is a branch
                        (i_rs1_D != 0) &&
                        (i_register_file_wr_en_E) &&        // and your instr in execute is gonna write to reg file
                        (i_register_file_wr_addr_E == i_rs1_D || i_register_file_wr_addr_E == i_rs2_D)) // and match up
                        ||
                        ((i_branch_D) &&                    // if your instr in decode is a branch
                        (i_rs1_D != 0) &&
                        (i_sel_result_M) &&                 // and your instr in memory result comes from data memory
                        (i_register_file_wr_addr_M == i_rs1_D || i_register_file_wr_addr_M == i_rs2_D)); // and match up

assign o_stall_D = lw_stall | branch_stall;
assign o_stall_F = lw_stall | branch_stall;
assign o_flush_E = lw_stall | branch_stall;

endmodule
//
//
//

module ALU_decoder (
    input [2:0] funct3,
    input [6:0] funct7,
    input [2:0] ctrl_ALU_op,
    output [3:0] ctrl_ALU
);

always @(*) begin
    case (ctrl_ALU_op)
    3'b010: begin   // R-type
        case (funct3)
        3'h0: ctrl_ALU <= (funct7 == 7'h00) ? 4'b0000 : 4'b0001; // ADD : SUB
        3'h1: ctrl_ALU <= 4'b0010; // SLL
        3'h2: ctrl_ALU <= 4'b0011; // SLT
        3'h3: ctrl_ALU <= 4'b0100; // SLTU
        3'h4: ctrl_ALU <= 4'b0101; // XOR
        3'h5: ctrl_ALU <= (funct7 == 7'h00) ? 4'b0110 : 4'b0111; // SRL : SRA
        3'h6: ctrl_ALU <= 4'b1000; // OR
        3'h7: ctrl_ALU <= 4'b1001; // AND
        endcase
    end
    3'b001: begin   // I-type ALU
        case (funct3) 
        3'h0: ctrl_ALU <= 4'b0000; // ADDI
        3'h1: ctrl_ALU <= 4'b0010; // SLLI
        3'h2: ctrl_ALU <= 4'b0011; // SLTI
        3'h3: ctrl_ALU <= 4'b0100; // SLTIU
        3'h4: ctrl_ALU <= 4'b0101; // XOR
        3'h5: ctrl_ALU <= (funct7 == 7'h00) ? 4'b0110 : 4'b0111; // SRLI (imm[5:11] = 0x00) : SRAI (imm[5:11] = 0x20)
        3'h6: ctrl_ALU <= 4'b1000; // ORI
        3'h7: ctrl_ALU <= 4'b1001; // ANDI
        endcase
    end
    endcase
end

endmodule
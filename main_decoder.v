//
//
//

module main_decoder (
    input [6:0] opcode,
    output reg ctrl_register_file_WE_D,
    output reg ctrl_srcB_D,
    output reg ctrl_register_file_WA_D,
    output reg ctrl_data_memory_WE_D,
    output reg ctrl_result_D,
    output reg [2:0] ctrl_ALU_op_D
);

parameter lw = 7'b0000011;
parameter add = 7'b0110011;

always @(*) begin
    case (opcode)
    lw: begin                           // load word
        ctrl_register_file_WE_D = 1'b1; // enable write to register file
        ctrl_srcB_D             = 1'b1; // srcB from sign_imm
        ctrl_register_file_WA_D = 1'b1; // write to rd register file
        ctrl_data_memory_WE_D   = 1'b0; // dont write to data memory
        ctrl_result_D           = 1'b1; // result comes from data memory
        ctrl_ALU_op_D           = 3'b010; // add
    end
    add: begin
        ctrl_register_file_WE_D = 1'b1; // enable write to register file
        ctrl_srcB_D             = 1'b0; // srcB from register file rd2
        ctrl_register_file_WA_D = 1'b1; // write to rd register file
        ctrl_data_memory_WE_D   = 1'b0; // dont write to data memory
        ctrl_result_D           = 1'b0; // result comes from ALU
        ctrl_ALU_op_D           = 3'b010; // add
    end
    default: begin
        ctrl_register_file_WE_D = 1'b0;
        ctrl_srcB_D             = 1'b0;
        ctrl_register_file_WA_D = 1'b0; 
        ctrl_data_memory_WE_D   = 1'b0; 
        ctrl_result_D           = 1'b0; 
        ctrl_ALU_op_D           = 3'b000; 
    end
    endcase
end

endmodule
// PC
// Program Counter (PC)

module program_counter (
    input clk,
    input rst,
    input en,
    input [31:0] i_PC_next,
    output reg [31:0] o_PC
);

always @(posedge clk) begin
    if (rst) begin
        o_PC <= 32'h00000000;
    end
    else if (en) begin
        o_PC <= i_PC_next;
    end
end

endmodule

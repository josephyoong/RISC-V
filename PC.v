// PC
// Program Counter (PC)

module PC (
    input clk,
    input rst,
    input [31:0] PC_next,
    output reg [31:0] PC
);

reg [31:0] r_PC;

initial begin
    PC = 32'h00000000;
end

always @(posedge clk) begin
    if (rst) begin
        PC <= 32'h00000000;
    end
    else begin
        PC <= PC_next;
    end
end

endmodule

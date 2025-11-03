// register_file
// Register File

module register_file (
    input clk,
    input WE3, // write enable
    input [4:0] A1, // address
    input [4:0] A2,
    input [4:0] A3, // destination address
    input [31:0] WD3, // write data
    output [31:0] RD1, // read data
    output [31:0] RD2
);

reg [31:0] r_register [0:31];

// SIMULATION: PRESET REGISTERS
initial begin
    r_register[16] = 32'h00000000;
    r_register[17] = 32'h00000003;
    r_register[18] = 32'h00000004;
end

always @(posedge clk) begin
    if (WE3 && (A3 != 5'b0)) begin
        r_register[A3] <= WD3;
    end
end

assign RD1 = r_register[A1];
assign RD2 = r_register[A2];

endmodule

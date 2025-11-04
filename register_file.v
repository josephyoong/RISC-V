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
    r_register[0]  = 32'h00000000;
    r_register[1]  = 32'h00000000;
    r_register[2]  = 32'h00000000;
    r_register[3]  = 32'h00000000;
    r_register[4]  = 32'h00000000;
    r_register[5]  = 32'h00000000;
    r_register[6]  = 32'h00000000;
    r_register[7]  = 32'h00000000;
    r_register[8]  = 32'h00000000;
    r_register[9]  = 32'h00000000;
    r_register[10] = 32'h00000000;
    r_register[11] = 32'h00000000;
    r_register[12] = 32'h00000000;
    r_register[13] = 32'h00000000;
    r_register[14] = 32'h00000000;
    r_register[15] = 32'h00000000;
    r_register[16] = 32'h00000000;
    r_register[17] = 32'h00000000;
    r_register[18] = 32'h00000000;
    r_register[19] = 32'h00000000;
    r_register[20] = 32'h00000000;
    r_register[21] = 32'h00000000;
    r_register[22] = 32'h00000000;
    r_register[23] = 32'h00000000;
    r_register[24] = 32'h00000000;
    r_register[25] = 32'h00000000;
    r_register[26] = 32'h00000000;
    r_register[27] = 32'h00000000;
    r_register[28] = 32'h00000000;
    r_register[29] = 32'h00000000;
    r_register[30] = 32'h00000000;
    r_register[31] = 32'h00000000;
end

always @(posedge clk) begin
    if (WE3 && (A3 != 5'b0)) begin
        r_register[A3] <= WD3;
    end
end

assign RD1 = r_register[A1];
assign RD2 = r_register[A2];

endmodule

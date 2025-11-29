// register_file
// Register File

module register_file (
    input clk,
    input i_wr_en, // write enable
    input [4:0] i_rd_addr1, // address
    input [4:0] i_rd_addr2,
    input [4:0] i_wr_addr, // destination address
    input [31:0] i_wr_data, // write data
    output [31:0] o_rd_data1, // read data
    output [31:0] o_rd_data2
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
    if (i_wr_en && (i_wr_addr != 5'b0)) begin
        r_register[i_wr_addr] <= i_wr_data;
    end
end

assign o_rd_data1 = r_register[i_rd_addr1];
assign o_rd_data2 = r_register[i_rd_addr2];

endmodule

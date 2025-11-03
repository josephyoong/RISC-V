// data_memory
// Data Memory

module data_memory #(
    parameter DATA_MEMORY_DEPTH = 256
) (
    input clk,
    input WE, // write enable
    input [31:0] WD, // write data
    input [31:0] A,
    output [31:0] RD
);

reg [31:0] r_data [0:DATA_MEMORY_DEPTH-1];

parameter ADDRESS_BIT_LENGTH = $clog2(256);

always @(posedge clk) begin
    if (WE) begin
        r_data[A[ADDRESS_BIT_LENGTH-1:0]] <= WD;
    end
end

assign RD = r_data[A[ADDRESS_BIT_LENGTH-1:0]];

endmodule
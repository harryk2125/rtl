`timescale 1ns/10ps

// Program counter:
module pc
#(
	parameter data_width = 32
)
// Input - Output:
(
	input logic [data_width-1:0] nxt_pc_i,
	input logic clk_i,
	input logic rst_ni,
	output logic [data_width-1:0] pc_o
);

always_ff @(posedge clk_i) begin: proc_pc
	pc_o = rst_ni ? nxt_pc_i : '0;
end

endmodule

`timescale 1ns/10ps

module add
#(
	parameter data_width = 32
)
(
	input logic [data_width-1:0] pc_i,
	output logic [data_width-1:0] pc_four_o
);

always_comb begin
	pc_four_o = pc_i + 4;
end
endmodule: add

`timescale 1ns/10ps

module mux221
#(
	parameter data_width = 32
)
(
	input logic [data_width-1:0] in1_i,
	input logic [data_width-1:0] in2_i,
	input logic sel_i,
	output logic [data_width-1:0] out_o
);

logic [data_width-1:0] out1, out2;

always_comb begin
	out_o = (sel_i == 0) ? in1_i : in2_i;
end

endmodule: mux221

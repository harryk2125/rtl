//module top (
//	input logic CLOCK_50,
//	input logic [4:0] SW,
//	
//	output logic [6:0] HEX0
//);
//
//pipeline pl_dut(
//	.clk_i		(CLOCK_50),
//	.rst_ni		(SW[4]),
//	.io_sw_i		(SW[3:0]),
//	.io_hex0_o	(HEX0)
//);
//
//endmodule: top
module top (
	input logic CLOCK_50,
	input logic [17:0] SW,
	
	output logic [6:0] HEX0,
	output logic [6:0] HEX1,
	output logic [6:0] HEX2,
	output logic [6:0] HEX3,
	output logic [6:0] HEX4
);

pipeline pl_dut(
	.clk_i		(CLOCK_50),
	.rst_ni		(SW[17]),
	.io_sw_i		(SW[15:0]),
	.io_hex0_o	(HEX0),
	.io_hex1_o	(HEX1),
	.io_hex2_o	(HEX2),
	.io_hex3_o	(HEX3),
	.io_hex4_o	(HEX4)
);

endmodule: top
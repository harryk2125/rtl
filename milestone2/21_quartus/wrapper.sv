module wrapper (
	input logic [17:16] SW,
	input logic 	CLOCK_27,
	
	output logic [6:0][0:0] HEX0
);	

singlecycle sc_dut(
	.clk_i			(CLOCK_27),
	.rst_ni			(SW[17]),
	.io_sw_i			(SW[16]),
	.pc_debug_o		(),
	.io_lcd_o		(),
	.io_ledg_o		(),
	.io_ledr_o		(),
	.io_hex0_o		(HEX0),
	.io_hex1_o		(),
	.io_hex2_o		(),
	.io_hex3_o		(),
	.io_hex4_o		(),
	.io_hex5_o		(),
	.io_hex6_o		(),
	.io_hex7_o		()
);

endmodule: wrapper
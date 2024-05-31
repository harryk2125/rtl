`timescale 1ns/10ps

module brcomp_tb;

logic	[31:0] 	rs1_data_i;
logic [31:0] 	rs2_data_i;
logic 			br_unsigned_i;

logic				br_less_o;
logic				br_equal_o;

brcomp brcomp_dut(
	.*
);

task tk_expect(
	input logic less,
	input logic equal
);
	$display("[%4d] rs1_data = %32b, rs2_data = %32b, br_unsigned = %1b, br_less = %1b, br_equal = %1b, less = %1b, equal = %1b", $time, rs1_data_i, rs2_data_i, br_unsigned_i, br_less_o, br_equal_o, less, equal);
	
	assert ((br_less_o == less) && (br_equal_o == equal)) else begin
		$display("TEST FAILED");
		$stop;
		end
endtask

initial begin
	#0  rs1_data_i = 32'b0; rs2_data_i = 32'b1; br_unsigned_i = 1'b1; #1 tk_expect(1'b1, 1'b0);
	#49	rs1_data_i = 32'b0; rs2_data_i = 32'b0; br_unsigned_i = 1'b1; #1 tk_expect(1'b0, 1'b1);
	#49	rs1_data_i = 32'b0; rs2_data_i = 32'hFFFFFFFF; br_unsigned_i = 1'b0; #1 tk_expect(1'b0, 1'b0);
	#49	rs1_data_i = 32'hF0AB0000; rs2_data_i = 32'h8902AF77; br_unsigned_i = 1'b1; #1 tk_expect(1'b0, 1'b0);
	#49	rs1_data_i = 32'h10FF6677; rs2_data_i = 32'h6902AF77; br_unsigned_i = 1'b0; #1 tk_expect(1'b1, 1'b0);
	#49	rs1_data_i = 32'hFF0B7ABC; rs2_data_i = 32'hFFFA7BC0; br_unsigned_i = 1'b0; #1 tk_expect(1'b1, 1'b0);
	#49	$display("TEST PASSED"); $finish;
	end

	endmodule : brcomp_tb

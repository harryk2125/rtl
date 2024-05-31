`timescale 1ns/10ps

module add_tb();

logic [31:0] pc_i;
logic [31:0] pc_four_o;

add add_dut(
	.*
);

task tk_expect(
	input [31:0] pc_four_x
);

	$display("[%4d] pc_i = %32b, pc_four_o = %32b, pc_four_x = %32b", $time, pc_i, pc_four_o, pc_four_x);
	
	assert (pc_four_o == pc_four_x) else begin
		$display("TEST FAILED");
		$stop;
	end
endtask

initial begin
	#0		pc_i = 32'hF00FA76E; #1 tk_expect(32'hF00FA772);
	#49	pc_i = 32'b0;			#1 tk_expect(32'h4);
	#49	$display("TEST PASSED"); $finish;
	end
	
endmodule: add_tb	

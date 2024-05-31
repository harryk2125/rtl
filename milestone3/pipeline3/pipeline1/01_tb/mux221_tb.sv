module mux221_tb();

logic [31:0] in1_i;
logic [31:0] in2_i;
logic 		 sel_i;
logic [31:0] out_o;

mux221 mux221_dut (
	.*
);

task tk_expect(
	input logic [31:0] out_x
);
	$display("in1_i = %32b, in2_i = %32b, sel_i = %1b, out_o = %32b, out_x = %32b", in1_i, in2_i, sel_i, out_o, out_x);
	
	assert (out_o == out_x) else begin
		$display("TEST FAILED");
		$stop;
	end
endtask

initial begin
	#0	in1_i = 32'hFFFFFFFF; in2_i = 32'b0; sel_i = 1'b0; #1 tk_expect(32'hFFFFFFFF);
	#49	in1_i = 32'hFFFFFFFF; in2_i = 32'b0; sel_i = 1'b1; #1 tk_expect(32'b0);
	#49	$display("TEST PASSED"); $finish;
end

endmodule: mux221_tb	

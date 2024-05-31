`timescale 1ns/10ps

module pc_tb ();

logic clk_i;
logic rst_ni;
logic [31:0] nxt_pc_i;
logic [31:0] pc_o;

pc pc_dut (
	.*
);

task tk_expect(
	input logic [31:0]  pc_x
);

	$display("[%4d] clk_i = %1b, rst_ni = %1b, nxt_pc = %32b, pc_o = %32b, pc_x = %32b", $time, clk_i, rst_ni , nxt_pc_i, pc_o, pc_x);
	assert (pc_o == pc_x) else begin
		$display("TEST FAILED");
		$stop;
	end
endtask

initial begin
  #0  clk_i = 1'b0;
  forever #50 clk_i = ~clk_i;
end

initial begin
  #0
  #50 rst_ni = 1'b0; nxt_pc_i = 32'hFFFFFFFF; #1 tk_expect(32'h0);
  #99 rst_ni = 1'b1; nxt_pc_i = 32'hF7;      ; #1 tk_expect(32'hF7);
  #99 $display("TEST PASSED"); $finish;
end

endmodule: pc_tb

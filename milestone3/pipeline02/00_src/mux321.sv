module mux321 (
	input logic [31:0] in1,
	input logic [31:0] in2,
	input logic [31:0] in3,
	input logic [1:0] mux_sel,
	output logic [31:0] out
);

	always_comb begin
		out = (mux_sel == 0) ? in1 : (mux_sel == 2'b01) ? in2 : (mux_sel == 2'b10) ? in3 : 2'b0;
	end
	
endmodule: mux321	
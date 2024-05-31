module IF_ID (
	input logic clk_i, rst_ni, 
	input logic [1:0]sel_i,
	input logic [31:0]ins_i, pc_i,
	output logic [31:0]ins_o, pc_o	
);
	always_ff @(posedge clk_i or negedge rst_ni) begin
		if (!rst_ni) begin //rst
				ins_o <= 32'b0;
				pc_o <= 32'b0;
			end
		else if (sel_i == 2'b11) begin //clr
				ins_o <= 32'b0;
				pc_o <= 32'b0;
			end
		else if (sel_i == 2'b00) begin 
				ins_o <= ins_i;
				pc_o <= pc_i;
			end
		end
endmodule	
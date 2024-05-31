module MEM_WB (
		input logic clk_i, rst_ni,//
		input logic sel_i,
		input logic [1:0]wb_seli,//
		input logic rd_wreni, 
		input logic [4:0]rd_adi,//
		input logic [31:0]alu_dai, ld_dai, pc_i,//
		
		output logic [1:0]wb_selo,//
		output logic rd_wreno, 
		output logic [4:0]rd_ado,//
		output logic [31:0]alu_dao, ld_dao, pc_o//
);
		logic [2:0]WB_i, WB_o;
		assign WB_i = {wb_seli, rd_wreni};
		assign {wb_selo, rd_wreno} = WB_o;
		
		always_ff @(posedge clk_i or negedge rst_ni) begin
				if (!rst_ni) begin
						WB_o <= 0;
						rd_ado <= 0;
						alu_dao <= 0;
						ld_dao <= 0;
						pc_o <= 0;
					end
				else if (sel_i == 1'b1) begin
						WB_o <= 0;
						rd_ado <= 0;
						alu_dao <= 0;
						ld_dao <= 0;
						pc_o <= 0;
					end
				else if (sel_i == 1'b0) begin
						WB_o <= WB_i;
						rd_ado <= rd_adi;
						alu_dao <= alu_dai;
						ld_dao <= ld_dai;
						pc_o <= pc_i;
					end
	end
endmodule		

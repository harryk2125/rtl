module EX_MEM (
		input logic clk_i, rst_ni,//
		input logic [1:0]sel_i,//
		input logic br_seli, mem_wreni, //
		input logic [2:0]fun_i,
		input logic [1:0]wb_seli,//
		input logic rd_wreni, 
		input logic [4:0]rd_adi,//
		input logic [31:0]alu_dai,rs2_dai,pc_i,//
		
		output logic br_selo, mem_wreno, //
		output logic [2:0]fun_o,
		output logic [1:0]wb_selo,//
		output logic rd_wreno, 
		output logic [4:0]rd_ado,//
		output logic [31:0]alu_dao,rs2_dao,pc_o//
);	

		logic [4:0]M_i, M_o;
		assign M_i = {br_seli, mem_wreni, fun_i};
		assign {br_selo, mem_wreno, fun_o} = M_o;
	
		logic [2:0]WB_i, WB_o;
		assign WB_i = {wb_seli, rd_wreni};
		assign {wb_selo, rd_wreno} = WB_o;
		
		always_ff @(posedge clk_i or negedge rst_ni) begin
				if (!rst_ni) begin
							M_o <= 0;
							WB_o <= 0;
							rd_ado <= 0;
							alu_dao <= 0;
							rs2_dao <= 0;
							pc_o <= 0;
					end
				else if (sel_i == 2'b11) begin //clr
							M_o <= 0;
							WB_o <= 0;
							rd_ado <= 0;
							alu_dao <= 0;
							rs2_dao <= 0;
							pc_o <= 0;
					end
				else if (sel_i == 2'b00) begin 
							M_o <= M_i;
							WB_o <= WB_i;
							rd_ado <= rd_adi;
							alu_dao <= alu_dai;
							rs2_dao <= rs2_dai;
							pc_o <= pc_i;
					end
	end
endmodule		

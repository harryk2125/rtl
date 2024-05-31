module ID_EX (
	input logic clk_i, rst_ni,//
	input logic [1:0]sel_i,//
	input logic op_ai, op_bi, //
	input logic [3:0]op_alu_i,
	input logic br_seli, mem_wreni, //
	input logic [2:0]fun_i,
	input logic [1:0]wb_seli,//
	input logic rd_wreni, 
	input logic [4:0]rd_adi,//
	input logic [31:0]pc_i, imm_i,//
	input logic [31:0]rs1_dai, rs2_dai,//
	input logic [4:0]rs1_addri, rs2_addri,//
	
	output logic op_ao, op_bo, //
	output logic [3:0]op_alu_o,
	output logic br_selo, mem_wreno, //
	output logic [2:0]fun_o,
	output logic [1:0]wb_selo,//
	output logic rd_wreno, 
	output logic [4:0]rd_ado,//
	output logic [31:0]pc_o, imm_o,//
	output logic [31:0]rs1_dao, rs2_dao,//
	output logic [4:0]rs1_addro, rs2_addro//
);
	logic [5:0]EX_i, EX_o;
	assign EX_i = {op_ai,op_bi,op_alu_i};
	assign {op_ao,op_bo,op_alu_o} = EX_o;
	
	logic [4:0]M_i, M_o;
	assign M_i = {br_seli, mem_wreni, fun_i};
	assign {br_selo, mem_wreno, fun_o} = M_o;
	
	logic [2:0]WB_i, WB_o;
	assign WB_i = {wb_seli, rd_wreni};
	assign {wb_selo, rd_wreno} = WB_o;
	
	always_ff @(posedge clk_i or negedge rst_ni) begin
		if (!rst_ni) begin
				EX_o <= 0;
				M_o <= 0;
				WB_o <= 0;
				rd_ado <= 0;
				pc_o <= 0;
				imm_o <= 0;
				rs1_dao <= 0;
				rs2_dao <= 0;
				rs1_addro <= 0;
				rs2_addro <= 0;
			end
		else if (sel_i == 2'b11) begin
				EX_o <= 0;
				M_o <= 0;
				WB_o <= 0;
				rd_ado <= 0;
				pc_o <= 0;
				imm_o <= 0;
				rs1_dao <= 0;
				rs2_dao <= 0;
				rs1_addro <= 0;
				rs2_addro <= 0;
			end
		else if (sel_i == 2'b00) begin 
				EX_o <= EX_i;
				M_o <= M_i;
				WB_o <= WB_i;
				rd_ado <= rd_adi;
				pc_o <= pc_i;
				imm_o <= imm_i;
				rs1_dao <= rs1_dai;
				rs2_dao <= rs2_dai;
				rs1_addro <= rs1_addri;
				rs2_addro <= rs2_addri;
			end
	end	
endmodule		

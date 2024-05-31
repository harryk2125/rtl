module brach(
	 input logic [6:0]branch_opcode,//
	 input logic [31:0]ifid_pc,//
	 input logic [4:0]ifid_rs1addr,//
	 input logic [4:0]ifid_rs2addr,
	 input logic [31:0]rs1data_idex,
	 input logic [4:0]idex_rdaddr,//
	 input logic idex_rdwren,
	 input logic [31:0]alu_exmem,//
	 input logic [4:0]exmem_rdaddr,
	 input logic exmem_rdwren,
	 input logic [31:0]exmem_alu,//
	 input logic [4:0]memwb_rdaddr,
	 input logic memwb_rdwren,
	 input logic [31:0]wbmux,//
	 input logic [31:0]imm_taken,//
	 output logic [31:0]pc_taken,	//
	 output logic[1:0]rs1_brsel,
	 output logic[1:0]rs2_brsel
	 
	);
	
	logic [31:0]data;
	
	assign rs1_brsel = ((idex_rdwren) && (idex_rdaddr != 0) && (idex_rdaddr == ifid_rs1addr)) ? 01 :
								((exmem_rdwren) && (exmem_rdaddr != 0) && (exmem_rdaddr == ifid_rs1addr)) ? 10 :
								00;
	
	assign rs2_brsel = ((idex_rdwren) && (idex_rdaddr != 0) && (idex_rdaddr == ifid_rs2addr)) ? 01 :
								((exmem_rdwren) && (exmem_rdaddr != 0) && (exmem_rdaddr == ifid_rs2addr)) ? 10 :
								00;
	
	
	assign data = ((idex_rdwren) && (idex_rdaddr != 0) && (idex_rdaddr == ifid_rs1addr)) ? alu_exmem :
						((exmem_rdwren) && (exmem_rdaddr != 0) && (exmem_rdaddr == ifid_rs1addr)) ? exmem_alu: 
						((memwb_rdwren) && (memwb_rdaddr != 0) && (memwb_rdaddr == ifid_rs1addr)) ? wbmux:
						rs1data_idex;
	
	assign pc_taken = (branch_opcode == 7'b1100011 || branch_opcode == 7'b1101111) ? (ifid_pc + imm_taken) :  
							(branch_opcode == 7'b1100111) ? (data + imm_taken) : 14'b0;
	
endmodule

	

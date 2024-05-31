module branch (
	input logic [4:0]ifid_rs1addr,  //
	input logic [4:0]ifid_rs2addr,
	
	input logic [4:0]idex_rdaddr,
	input logic idex_rdwren,
	
	input logic [4:0]exmem_rdaddr,
	input logic exmem_rdwren,
	
	output logic [1:0]rs1_brsel,
	output logic [1:0]rs2_brsel
);
	assign rs1_brsel = ((idex_rdwren) && (idex_rdaddr!=0) && (ifid_rs1addr == idex_rdaddr)) ? 01: 
								((exmem_rdwren) && (exmem_rdaddr!=0) && (ifid_rs1addr == exmem_rdaddr)) ? 10:
								00;
	assign rs2_brsel = ((idex_rdwren) && (idex_rdaddr!=0) && (ifid_rs2addr == idex_rdaddr)) ? 01: 
								((exmem_rdwren) && (exmem_rdaddr!=0) && (ifid_rs2addr == exmem_rdaddr)) ? 10:
								00;
								
endmodule


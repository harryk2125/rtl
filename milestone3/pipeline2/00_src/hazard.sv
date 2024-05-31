module hazard
    (
	 input logic [1:0]ID_EX_rs1addr,
	 input logic [1:0]ID_EX_rs2addr,
	 
	 input logic [1:0]EX_MEM_wbsel,
	 input logic [4:0]EX_MEM_rdaddr,
	 input logic EX_MEM_rdwren,
	 
	 input logic EX_MEM_brsel,

    output logic [7:0] stall
    );
    //00: no stall, 01: stallB, 10: stallC
	assign stall = (EX_MEM_brsel) ? 8'b0_11_11_11_0 : //078
				((EX_MEM_wbsel == 2'b10)&&(EX_MEM_rdaddr != 0)&&(EX_MEM_rdwren == 1'b1)&&((EX_MEM_rdaddr == ID_EX_rs1addr)||(EX_MEM_rdaddr == ID_EX_rs2addr))) ? 8'b1_01_01_11_0 : //AE 
				 8'b0; 

endmodule

module hazard
    (
	 input logic [1:0]ID_EX_wbsel,
	 input logic [4:0]ID_EX_rdaddr,
	 input logic ID_EX_rdwren,
	 
	 input logic [1:0]EX_MEM_wbsel,
	 input logic [4:0]EX_MEM_rdaddr,
	 input logic EX_MEM_rdwren,
	 
	 input logic [1:0]MEM_WB_wbsel,
	 input logic [4:0]MEM_WB_rdaddr,
	 input logic MEM_WB_rdwren,
	 
	 input logic controlunit_brsel,

    output logic [7:0] stall
    );
    //00: no stall, 01: stallB, 10: stallC
	assign stall = (controlunit_brsel) ? 8'b0_11_00_00_0 : //060
				((ID_EX_wbsel == 2'b10)&&(ID_EX_rdaddr != 0)&&(ID_EX_rdwren == 1'b1)) ? 8'b1_01_11_00_0 : //B8
				((EX_MEM_wbsel == 2'b10)&&(EX_MEM_rdaddr != 0)&&(EX_MEM_rdwren == 1'b1)) ? 8'b1_01_01_11_0 : //AE
				((MEM_WB_wbsel == 2'b10)&&(MEM_WB_rdaddr != 0)&&(MEM_WB_rdwren == 1'b1)) ? 8'b1_01_01_01_1 : //AB
												8'b0; 

endmodule

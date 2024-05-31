module hazard
    (
    input logic [4:0] IF_ID_RS1,
    input logic [4:0] IF_ID_RS2,
    input logic [4:0] ID_EX_rd,
    input logic ID_EX_regwren,
    input logic [4:0] EX_MEM_rd,
    input logic EX_MEM_regwren,
	 input logic [4:0] MEM_WB_rd,
    input logic MEM_WB_regwren,
	 input logic EX_MEM_brsel,

    output logic [7:0] stall
    );
    //00: no stall, 01: stallB, 10: stallC
	assign stall = (EX_MEM_brsel) ? 8'b0_11_11_11_0 : 
//					((MEM_WB_regwren)&&(MEM_WB_rd != 0)&&((MEM_WB_rd == IF_ID_RS1)||(MEM_WB_rd == IF_ID_RS2))) ? 8'b1_01_01_01_1 : // AB
					((EX_MEM_regwren)&&(EX_MEM_rd != 0)&&((EX_MEM_rd == IF_ID_RS1)||(EX_MEM_rd == IF_ID_RS2))) ? 8'b1_01_01_11_0 : // AE
					((ID_EX_regwren)&&(ID_EX_rd != 0)&&((ID_EX_rd == IF_ID_RS1)||(ID_EX_rd == IF_ID_RS2))) ? 8'b1_01_11_00_0 : // B8
					8'b0; 

endmodule

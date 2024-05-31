module pipeline
(
  //INPUT
  input logic [31:0]  io_sw_i   ,  
  //OUTPUT
  output logic [31:0] io_lcd_o  ,
  output logic [31:0] io_ledg_o ,
  output logic [31:0] io_ledr_o ,
  output logic [31:0] io_hex0_o ,
  output logic [31:0] io_hex1_o ,
  output logic [31:0] io_hex2_o ,
  output logic [31:0] io_hex3_o ,
  output logic [31:0] io_hex4_o ,
  output logic [31:0] io_hex5_o ,
  output logic [31:0] io_hex6_o ,
  output logic [31:0] io_hex7_o ,

  input logic         clk_i     ,
  input logic         rst_ni
);
	logic [7:0]hz_o;
	
	logic [31:0] exmem_alu, add_pc, muxpc_pc, hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
	logic exmem_brsel;	
	mux221 muxpc (add_pc, exmem_alu, exmem_brsel, muxpc_pc);
	
	
	logic hz_ff;
	logic [31:0]ff_ins;
	flipflop ff (clk_i, rst_ni, muxpc_pc, hz_o[7], ff_ins); // flipflop pc
	
	add add4 (ff_ins, add_pc);
	
	logic [31:0] ins_ifid;
	inst_memory inst (ff_ins, ins_ifid, clk_i, rst_ni);
	
	logic [31:0]idif_ins, idif_pc;
	IF_ID ifid (clk_i, rst_ni, hz_o[6:5], ins_ifid ,ff_ins, idif_ins, idif_pc);  
	
	logic [31:0]imm_idex;
	immgen imm (idif_ins, imm_idex);
	
	logic memwb_rdwren;
	logic [4:0]memwb_rdaddr;
	logic [31:0]wb_rddata, rs1_idex, rs2_idex;
	regfile rf(clk_i, rst_ni, memwb_rdwren, idif_ins[19:15], idif_ins[24:20], memwb_rdaddr, wb_rddata, rs1_idex, rs2_idex);
	
	logic br_unsigned, br_less, br_equal;
	brcomp brc (rs1_idex, rs2_idex, br_unsigned, br_less, br_equal);
	
	logic brsel_idex, rdwren_idex, opasel_idex, opbsel_idex, memwwren_idex;
	logic [4:0]alusel_idex;
	logic [2:0]fun_idex; 
	logic [1:0]wbsel_idex;
	controlunit ctrl (idif_ins, br_less, br_equal, brsel_idex, br_unsigned, rdwren_idex, opasel_idex, opbsel_idex, alusel_idex, memwwren_idex, fun_idex, wbsel_idex);
	
	logic opasel, opbsel, brsel_exmem, memwren_exmem, rdwren_exmem;
	logic [4:0]rdaddr_exmem;
	logic [3:0]opalu;
	logic [2:0]fun_exmem;
	logic [1:0]wbsel_exmem;
	logic [31:0]pcmux, immmux, rs1mux, rs2mux;
	ID_EX idex (clk_i, rst_ni, hz_o[4:3], opasel_idex, opbsel_idex, alusel_idex, brsel_idex, memwwren_idex, fun_idex, wbsel_idex, rdwren_idex, idif_ins[11:7], idif_pc, imm_idex, rs1_idex, rs2_idex, 
					opasel, opbsel, opalu, brsel_exmem, memwren_exmem, fun_exmem, wbsel_exmem, rdwren_exmem, rdaddr_exmem, pcmux, immmux, rs1mux, rs2mux);
	
	logic [31:0]opa_alu;
	mux221 muxopa (rs1mux, pcmux, opasel, opa_alu);
	
	logic [31:0]opb_alu;
	mux221 muxopb (rs2mux, immmux, opbsel, opb_alu);
	
	logic [31:0]alu_exmem;
	alu aluu (opa_alu, opb_alu, opalu, alu_exmem);
	
	logic exmem_memwren, exmem_fun, rdwrem_memwb;
	logic [1:0]wbsel_memwb;
	logic [4:0]rdaddr_memwb;
	logic [31:0]exmem_rs2,exmem_pc;
	EX_MEM exmem (clk_i, rst_ni, hz_o[2:1], brsel_exmem, memwren_exmem, fun_exmem, wbsel_exmem, rdwren_exmem, rdaddr_exmem, alu_exmem, rs2mux,pcmux,
						exmem_brsel, exmem_memwren, exmem_fun, wbsel_memwb, rdwrem_memwb, rdaddr_memwb, exmem_alu, exmem_rs2, exmem_pc );
	
	logic [31:0]lddata_memwb;
	lsu lsuu (clk_i, rst_ni, exmem_alu, exmem_fun, exmem_memwren, exmem_rs2,
				io_sw_i, lddata_memwb, io_lcd_o, io_ledg_o, io_ledr_o, hex0, hex1, hex2, hex3, hex4 , hex5, hex6, hex7);
				
hexled hled0 (
	.data_i	(hex0),
	.hex_o	(io_hex0_o)
);

hexled hled1 (
	.data_i	(hex1),
	.hex_o	(io_hex1_o)
);

hexled hled2 (
	.data_i	(hex2),
	.hex_o	(io_hex2_o)
);

hexled hled3 (
	.data_i	(hex3),
	.hex_o	(io_hex3_o)
);

hexled hled4 (
	.data_i	(hex4),
	.hex_o	(io_hex4_o)
);

hexled hled5 (
	.data_i	(hex5),
	.hex_o	(io_hex5_o)
);

hexled hled6 (
	.data_i	(hex6),
	.hex_o	(io_hex6_o)
);

hexled hled7 (
	.data_i	(hex7),
	.hex_o	(io_hex7_o)
);			
	
	logic [1:0]memwb_wbsel;
	logic [31:0]memwb_aludata, memwb_lddata, memwb_pc;
	MEM_WB memwb (clk_i, rst_ni, hz_o[0], wbsel_memwb, rdwrem_memwb, rdaddr_memwb, exmem_alu, lddata_memwb, exmem_pc,
						memwb_wbsel, memwb_rdwren, memwb_rdaddr, memwb_aludata, memwb_lddata, memwb_pc);
	
	
	wbmux wb (memwb_lddata, memwb_aludata, memwb_pc, memwb_wbsel, wb_rddata);
	
	hazard (idif_ins[19:15], idif_ins[24:20], rdaddr_exmem, rdwren_exmem, rdaddr_memwb, rdwrem_memwb, memwb_rdaddr ,memwb_rdwren, exmem_brsel, hz_o);
	

endmodule: pipeline

// Convert hex to 7-segment leds digits (0-9/A-F)
module hexled (
  // input
  input logic [31:0]  data_i,

  // output
  output logic [31:0] hex_o
);

  always_comb begin : proc_7seg_decoder
    case (data_i)
	    32'h0: hex_o = 32'h40;
	    32'h1: hex_o = 32'h79;
	    32'h2: hex_o = 32'h24;
	    32'h3: hex_o = 32'h30;
	    32'h4: hex_o = 32'h19;
	    32'h5: hex_o = 32'h12;
	    32'h6: hex_o = 32'h02;
	    32'h7: hex_o = 32'h58;
	    32'h8: hex_o = 32'h00;
	    32'h9: hex_o = 32'h18;
	    32'ha: hex_o = 32'h08;
	    32'hb: hex_o = 32'h03;
	    32'hc: hex_o = 32'h46;
	    32'hd: hex_o = 32'h21;
	    32'he: hex_o = 32'h06;
	    32'hf: hex_o = 32'h0e;
      default: hex_o = 32'h7f;
    endcase
  end

endmodule : hexled


`timescale 1ns/10ps

module singlecycle
#(
	parameter data_width = 32
)
// Inputs - Outputs:
(
	input logic clk_i,									        // Clock
	input logic rst_ni,									        // Low negative reset 
	input logic [data_width-1:0] io_sw_i,			  // 32 bits for Switches
	
//	output logic [data_width-1:0] inst_o,
//	output logic [data_width-1:0] op_ao,
//	output logic [data_width-1:0] op_bo,
//	output logic [data_width-1:0] aluo,
//	output logic [data_width-1:0] ld_datao,
	output logic [data_width-1:0] pc_debug_o,		// PC
	output logic [data_width-1:0] io_lcd_o,		  // 32 bit-data drive LCD
	output logic [data_width-1:0] io_ledg_o,		// 32 bit-data to drive green LEDs
	output logic [data_width-1:0] io_ledr_o,		// 32 bit-data to drive red LEDs
	output logic [data_width-1:0] io_hex0_o,		// 
	output logic [data_width-1:0] io_hex1_o,		//
	output logic [data_width-1:0] io_hex2_o,		//
	output logic [data_width-1:0] io_hex3_o,		// 8 32 bit-data to drive 7-segment LEDs
	output logic [data_width-1:0] io_hex4_o,		//
	output logic [data_width-1:0] io_hex5_o,		//
	output logic [data_width-1:0] io_hex6_o,		//
	output logic [data_width-1:0] io_hex7_o		//
);

// Variables (wiring between modules)
// 32 bit-data:
logic [data_width-1:0] nxt_pc, pc, pc_four, instr, rs1_data, rs2_data, operand_a, operand_b, imm, alu_data, ld_data, wb_data, hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
// 1 bit-data:
logic br_sel, rd_wren, br_unsigned, br_less, br_equal, op_a_sel, op_b_sel, mem_wren;
// Others:
logic [1:0] wb_sel;
logic [2:0] fun;
logic [3:0] alu_op;

// Mux 2 to 1 before PC:
mux221 muxpc (
	.in1_i	(pc_four),
	.in2_i	(alu_data),
	.sel_i	(br_sel),
	.out_o	(nxt_pc)
);

// Program Counter (PC)
pc programcounter (
	.nxt_pc_i	(nxt_pc),
	.clk_i		(clk_i),
	.rst_ni		(rst_ni),
	.pc_o			(pc)
);

// PC <- PC + 4
add add4 (
	.pc_i			(pc),
	.pc_four_o	(pc_four)
);

// Instr_mem
inst_memory is (
	.clk_i		(clk_i),
	.rst_ni		(rst_ni),
	.paddr_i		(pc),
	.prdata_o	(instr)
);

// Regfile
regfile rfile (
	.clk_i		(clk_i),
	.rst_ni		(rst_ni),
	.rd_wren		(rd_wren),
	.rs1_addr	(instr[19:15]),
	.rs2_addr	(instr[24:20]),
	.rd_addr		(instr[11:7]),
	.rd_data		(wb_data),
	.rs1_data	(rs1_data),
	.rs2_data	(rs2_data)
);

// Immediate generator: 
immgen immedgenerator (
	.instr_i		(instr),
	.imm_o		(imm)
);

// Branch comparator:
brcomp brc (
	.rs1_data_i		(rs1_data),
	.rs2_data_i		(rs2_data),
	.br_unsigned_i	(br_unsigned),
	.br_less_o		(br_less),
	.br_equal_o		(br_equal)
);

// Mux 2 to 1: Operand_a
mux221 mux_op_a (
	.in1_i	(rs1_data),
	.in2_i	(pc),
	.sel_i	(op_a_sel),
	.out_o	(operand_a)
);

// Mux 2 to 1: Operand_b
mux221 mux_op_b (
	.in1_i	(rs2_data),
	.in2_i	(imm),
	.sel_i	(op_b_sel),
	.out_o	(operand_b)
);

// Algithemic Logic Unit (ALU)
alu alunit (
	.operand_a_i	(operand_a),
	.operand_b_i	(operand_b),
	.alu_op_i		(alu_op),
	.alu_data_o		(alu_data)
);

// Load - Store Unit (LSU)
lsu lsunit (
	.clk_i		(clk_i),
	.rst_ni		(rst_ni),
	.addr_i		(alu_data),
  .func_i   (fun),
	.st_data_i	(rs2_data),
	.st_en_i		(mem_wren),
	.sw_data_i		(io_sw_i),
	.ld_data_o	(ld_data),
	.io_lcd_o	(io_lcd_o),
	.io_ledg_o	(io_ledg_o),
	.io_ledr_o	(io_ledr_o),
	.io_hex0_o	(hex0),
	.io_hex1_o	(hex1),
	.io_hex2_o	(hex2),
	.io_hex3_o	(hex3),
	.io_hex4_o	(hex4),
	.io_hex5_o	(hex5),
	.io_hex6_o	(hex6),
	.io_hex7_o	(hex7)
);

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
// WB Mux:
wbmux mux3to1 (
	.ld_data_i	(ld_data),
	.alu_data_i	(alu_data),
	.pc_four_i	(pc_four),
	.wb_sel_i	(wb_sel),
	.wb_data_o	(wb_data)
);

// Control Unit:
controlunit ctrunit (
  .instr_i        (instr),
  .br_less_i      (br_less),
  .br_equal_i     (br_equal),
  .br_sel_o       (br_sel),
  .br_unsigned_o  (br_unsigned),
  .rd_wren_o      (rd_wren),
  .op_a_sel_o     (op_a_sel),
  .op_b_sel_o     (op_b_sel),
  .alu_op_o       (alu_op),
  .mem_wren_o     (mem_wren),
  .fun_o          (fun),
  .wb_sel_o       (wb_sel)
);

//assign inst_o = instr;
//assign op_ao = operand_a;
//assign op_bo = operand_b;
//assign aluo = alu_data;
//assign ld_datao = ld_data;

endmodule: singlecycle

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


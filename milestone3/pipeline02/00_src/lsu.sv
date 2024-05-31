`timescale 1ns/10ps

module lsu
  #(parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32)
  (
  // inputs
  input logic              clk_i,
  input logic              rst_ni,
  input [ADDR_WIDTH-1:0]   addr_i,
  input [2: 0]             func_i,
   
  input logic              st_en_i,
  input [DATA_WIDTH-1: 0] 	st_data_i,
  input [DATA_WIDTH-1: 0] 	sw_data_i,

  // outputs
  output [DATA_WIDTH-1:0]  ld_data_o,
  output [DATA_WIDTH-1:0] 	io_lcd_o,
  output [DATA_WIDTH-1:0] 	io_ledg_o,
  output [DATA_WIDTH-1:0]  io_ledr_o,
  
  output [DATA_WIDTH-1:0]  io_hex0_o,
  output [DATA_WIDTH-1:0]  io_hex1_o,
  output [DATA_WIDTH-1:0]  io_hex2_o,
  output [DATA_WIDTH-1:0]  io_hex3_o,
  output [DATA_WIDTH-1:0]  io_hex4_o,
  output [DATA_WIDTH-1:0]  io_hex5_o,
  output [DATA_WIDTH-1:0]  io_hex6_o,
  output [DATA_WIDTH-1:0]  io_hex7_o
);
  wire [5:0] true_addr = addr_i[7:2];
  wire [3:0] bank_sel = addr_i[11:8];
  wire [DATA_WIDTH-1: 0] ld_data_ip;
  wire [DATA_WIDTH-1: 0] ld_data_op;
  wire [DATA_WIDTH-1: 0] ld_data_d;
//  logic [3:0][7:0] dmem [0:2**(12-2)-1];
							 
// input perripherals mem
  lsu_2d_ip_bank lsu_2d_ip(
    .clk_i    (clk_i),
    .rst_ni   (rst_ni),	
    .paddr_i  (true_addr),
    .penable_i(bank_sel == 4'd9),
    .pfunct_code_i	(func_i),
    .pwdata_i (sw_data_i),
//	 .dmem(dmem[576:639]),
	 
    .prdata_o (ld_data_ip)
	);

// output perripherals mem
  lsu_2d_op_bank lsu_2d_op(
    .clk_i     (clk_i),
    .rst_ni    (rst_ni),
    .paddr_i   (true_addr),
    .penable_i (bank_sel == 4'd8),
    .pfunct_code_i	(func_i),
    .pwrite_i  (st_en_i),
    .pwdata_i  (st_data_i),
//	 .dmem(dmem[512:575]),
		
    .prdata_o  (ld_data_op),	
    .io_lcd_o  (io_lcd_o),
    .io_ledg_o (io_ledg_o),
    .io_ledr_o (io_ledr_o),	
    .io_hex0_o (io_hex0_o),
    .io_hex1_o	(io_hex1_o),
    .io_hex2_o	(io_hex2_o),
    .io_hex3_o	(io_hex3_o),
    .io_hex4_o	(io_hex4_o),
    .io_hex5_o	(io_hex5_o),
    .io_hex6_o	(io_hex6_o),
    .io_hex7_o	(io_hex7_o)
  );
	
// D mem
  lsu_2d_bank lsu_2d_dmem(
    .clk_i     (clk_i),
    .rst_ni    (rst_ni),
    .paddr_i   (addr_i[10:2]),
    .penable_i	(bank_sel < 4'd8),	
    .pwrite_i  (st_en_i),
    .pwdata_i  (st_data_i),
	 .pfunct_code_i	(func_i),
//	 .dmem(dmem[0:511]),
 
    .prdata_o  (ld_data_d)
  );
	
  assign ld_data_o = (addr_i[11] == 2'd0)  ? ld_data_d  :
                     ((bank_sel 		 == 4'd8) ? ld_data_op :
                     ((bank_sel 		 == 4'd9) ? ld_data_ip : 'z));

  wire _unused_ok = &{ addr_i[1:0], addr_i[31:12]};

endmodule : lsu

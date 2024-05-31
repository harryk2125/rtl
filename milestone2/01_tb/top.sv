module top (
  // Inputs:
  input logic clk_i,
  input logic rst_ni,
  input logic [31:0] io_sw_i,
  
  // Outputs:
  output logic [31:0] pc_debug_o,
  output logic [31:0] io_lcd_o,
  output logic [31:0] io_ledg_o,
  output logic [31:0] ledr_o,
  output logic [31:0] hex0_o,
  output logic [31:0] hex1_o,
  output logic [31:0] hex2_o,
  output logic [31:0] hex3_o,
  output logic [31:0] hex4_o,
  output logic [31:0] hex5_0,
  output logic [31:0] hex6_o,
  output logic [31:0] hex7_o
);

singlecycle singleCycle(
  .*
);

endmodule: top

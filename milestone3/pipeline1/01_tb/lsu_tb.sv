`timescale 1ns/10ps

module lsu_tb;

 logic clk_i, rst_ni;

  logic [11:0] addr_i;
  logic [31:0] st_data_i;
  logic [17:0] io_sw_i;
  logic st_en_i;

  logic [31:0] ld_data_o;
  logic [31:0] io_lcd_o, io_ledg_o, io_ledr_o;
  logic [31:0] io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o;
  logic [31:0] io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o;

  lsu dut (
	.*
  );

    task tk_expect(
    input logic [31:0] data_x
  );

    $display("[%4d] clk_i = %1b, rst_ni = %1b, addr = %11b, st_data = %32b, ld_data = %32b, data_x = %32b", $time, clk_i, rst_ni, addr_i, st_data_i, ld_data_o, data_x);
    
    assert(ld_data_o == data_x) else begin
      $display("TEST FAILED");
      $stop;
    end
  endtask
  
  initial begin
    #0 clk_i = 1'b0;
    forever #50 clk_i = ~clk_i;
  end
  
  initial begin
    rst_ni = 1'b0;
    #49; 
    rst_ni = 1'b1;
    addr_i = 12'h001; 
    st_en_i = 1'b1;
    st_data_i = 32'hDEADBEEF;
    #100;
    st_en_i = 1'b0;
    addr_i = 12'h001;
    #1   
    tk_expect(32'hDEADBEEF);
  end


endmodule

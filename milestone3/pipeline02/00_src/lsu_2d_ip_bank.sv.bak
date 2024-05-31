`timescale 1ns/10ps

module lsu_2d_ip_bank #(
  parameter int unsigned DMEM_W = 8,
  parameter int unsigned DMEM_ADDR = 6
) (
  // APB Protocol
  input  logic [DMEM_ADDR-1:0] paddr_i,
  input  logic              penable_i,  
  input  logic [31:0]       pwdata_i ,
  input  logic [2:0]        pfunct_code_i,
  
  output logic [31:0]       prdata_o,
  /* verilator lint_off UNUSED */
  input  logic              clk_i   ,
  input  logic              rst_ni
  /* verilator lint_on UNUSED */
);

  logic [3:0][7:0] dmem [0:2**(DMEM_W-2)-1];
 
  initial begin
    $readmemh("../30_mem/ip.mem", dmem);
  end

  // Read - Write
  always_ff @(posedge clk_i) begin : proc_data
        dmem[0] <= pwdata_i;
		$writememh("../30_sim/ip.mem", dmem);
  end

  logic [31: 0] rd_reg;
  
  always_comb begin : extends_by_imm_sel
    case (pfunct_code_i)
      3'b000:  rd_reg = {{24{dmem[paddr_i][0][7]}}, dmem[paddr_i][0]};
      3'b001:  rd_reg = {{16{dmem[paddr_i][1][7]}}, dmem[paddr_i][1:0]};
      3'b010:  rd_reg = dmem[paddr_i];
      3'b100:  rd_reg = {24'd0, dmem[paddr_i][0]};
      3'b101:  rd_reg = {16'd0 ,dmem[paddr_i][1:0]};
      default: rd_reg = 32'd0;
    endcase
	end
	
  assign prdata_o = penable_i ? rd_reg : 'z;

endmodule : lsu_2d_ip_bank

`timescale 1ns/10ps

module lsu_2d_bank #(
  parameter int unsigned DMEM_W = 11,
  parameter int unsigned DMEM_ADDR = 9
) 
(
  // APB Protocol
  input  logic [DMEM_ADDR-1:0] paddr_i  ,
  input  logic              penable_i,
  input  logic              pwrite_i ,
  input  logic [31:0]       pwdata_i ,
  
  input  logic [2:0]        pfunct_code_i,
  output logic [31:0]       prdata_o ,

  /* verilator lint_off UNUSED */
  input  logic              clk_i   ,
  input  logic              rst_ni  
  /* verilator lint_on UNUSED */
);

  logic [3:0][7:0] dmem [0:2**(DMEM_W-2)-1];

  wire  [3:0] pstrb = (pfunct_code_i == 3'd0) ? 4'b0001 :
                      (pfunct_code_i == 3'd1) ? 4'b0011 :
                      (pfunct_code_i == 3'd2) ? 4'b1111 : 4'b0000;

  // Read - Write
  initial begin
    //$readmemh("../30_mem/datamem.data", dmem);
  end
 
  always_ff @(posedge clk_i) begin : proc_data
    if (penable_i && pwrite_i) begin
      if (pstrb[0]) begin
        dmem[paddr_i][0] <= pwdata_i[7: 0];
      end
      if (pstrb[1]) begin
        dmem[paddr_i][1] <= pwdata_i[15: 8];
      end
      if (pstrb[2]) begin
        dmem[paddr_i][2] <= pwdata_i[23:16];
      end
      if (pstrb[3]) begin
        dmem[paddr_i][3] <= pwdata_i[31:24];
      end
    end
    $writememh("../30_mem/datamem.data", dmem);
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

endmodule : lsu_2d_bank

module forwarding
    (
     input logic [4:0] idex_RS1,
     input logic [4:0] idex_RS2,
     input logic [4:0] EX_MEM_rd,
     input logic [4:0] MEM_WB_rd,
     input logic EX_MEM_RegWrite,
     input logic MEM_WB_RegWrite,
     output logic [1:0] Forward_A,
     output logic [1:0] Forward_B
    );
   //00:no Forward; 10:Forward from MEM; 01:Forward from WB
    assign Forward_A = ((EX_MEM_RegWrite) && (EX_MEM_rd != 0) && (EX_MEM_rd == idex_RS1)) ? 2'b10 :
                       ((MEM_WB_RegWrite) && (MEM_WB_rd != 0) && (MEM_WB_rd == idex_RS1)) ? 2'b01 : 2'b00;

    assign Forward_B = ((EX_MEM_RegWrite) && (EX_MEM_rd != 0) && (EX_MEM_rd == idex_RS2)) ? 2'b10 :
                       ((MEM_WB_RegWrite) && (MEM_WB_rd != 0) && (MEM_WB_rd == idex_RS2)) ? 2'b01 : 2'b00;


endmodule: forwarding

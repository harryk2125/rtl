module flipflop(
  input logic clk_i, rst_ni,
  input logic [31:0] d,
  input logic sel_i,

  output logic [31:0] q
);

    always_ff @(posedge clk_i or negedge rst_ni)
		 begin
				  if (!rst_ni) q <= 0;
				  else if (sel_i == 0) q<=d;
			end        
endmodule 
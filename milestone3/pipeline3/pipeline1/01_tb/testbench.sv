module testbench();
	
	logic clk_i;
	logic rst_ni;
	logic rd_wren;
	logic [4:0] rs1_addr;
	logic [4:0] rs2_addr;
	logic [4:0] rd_addr;
	logic [31:0] rd_data;
	logic [31:0] rs1_data;
	logic [31:0] rs2_data;
	
	regfile dut(clk_i, rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data, rs1_data, rs2_data);
	
	initial begin
		clk_i = 0;
		forever #5 clk_i = ~clk_i;
		end

	
	initial begin
		$dumpvars (0,testbench);
		
		#5;
		rst_ni = 0;
		rd_wren = 0;
		rd_addr = 5'b00;
		rd_data = 32'b0000;
		rs1_addr = 5'b10;
		rs2_addr = 32'b11;
		$display("test case 1: rst_ni=%b, rd_wren=%b, rs1_addr=%b, rs2_addr=%b,rd_addr=%b,rd_data=%b",rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data);

		
		#10;
		rst_ni = 1;
		rd_wren = 1;
		rd_addr = 5'b10;
		rd_data = 32'b1111;
		rs1_addr = 5'b00;
		rs2_addr = 32'b11;
		$display("test case 2: rst_ni=%b, rd_wren=%b, rs1_addr=%b, rs2_addr=%b,rd_addr=%b,rd_data=%b",rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data);
		
		#10;
		rst_ni = 1;
		rd_wren = 1;
		rd_addr = 5'b11;
		rd_data = 32'b1010;
		rs1_addr = 5'b00;
		rs2_addr = 32'b10;
		$display("test case 3: rst_ni=%b, rd_wren=%b, rs1_addr=%b, rs2_addr=%b,rd_addr=%b,rd_data=%b",rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data);
		
		#10;
		rst_ni = 1;
		rd_wren = 1;
		rd_addr = 5'b11;
		rd_data = 32'b0100;
		rs1_addr = 5'b10;
		rs2_addr = 32'b11;
		$display("test case 4: rst_ni=%b, rd_wren=%b, rs1_addr=%b, rs2_addr=%b,rd_addr=%b,rd_data=%b",rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data);
		
		#10;
		rst_ni = 0;
		rd_wren = 1;
		rd_addr = 5'b01;
		rd_data = 32'b1110;
		rs1_addr = 5'b01;
		rs2_addr = 32'b11;
		$display("test case 5: rst_ni=%b, rd_wren=%b, rs1_addr=%b, rs2_addr=%b,rd_addr=%b,rd_data=%b",rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data);
		
		#10;
		rst_ni = 1;
		rd_wren = 1;
		rd_addr = 5'b00;
		rd_data = 32'b0000;
		rs1_addr = 5'b10;
		rs2_addr = 32'b00;
		$display("test case 6: rst_ni=%b, rd_wren=%b, rs1_addr=%b, rs2_addr=%b,rd_addr=%b,rd_data=%b",rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data);
		
		#10;
		rst_ni = 1;
		rd_wren = 1;
		rd_addr = 5'b00;
		rd_data = 32'b0000;
		rs1_addr = 5'b10;
		rs2_addr = 32'b00;
		$display("test case 7: rst_ni=%b, rd_wren=%b, rs1_addr=%b, rs2_addr=%b,rd_addr=%b,rd_data=%b",rst_ni, rd_wren, rs1_addr, rs2_addr,rd_addr, rd_data);
		
		$finish;
	end
	
	always @(posedge clk_i)
	$display ("(TIME=%t), rs1_data=%b, rs2_data=%b", $time,rd_data, rs1_data, rs2_data);
		
endmodule		
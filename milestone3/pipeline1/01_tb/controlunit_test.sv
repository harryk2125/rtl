//`timescale 1ns/1ns
module controlunit_test ();
		logic [31:0] instr_i;
		logic br_less_i;
		logic br_equal_i;
		logic br_sel_o;
		logic br_unsigned_o;
		logic rd_wren_o;
		logic op_a_sel_o;
		logic op_b_sel_o;
		logic [3:0] alu_op_o;
		logic mem_wren_o;
		logic [1:0] wb_sel_o;

controlunit dut (instr_i, br_less_i, br_equal_i, br_sel_o, br_unsigned_o, rd_wren_o, op_a_sel_o, op_b_sel_o, alu_op_o, mem_wren_o, wb_sel_o);

	reg clk=0;
	always #5 clk=~clk;

	initial begin 	

			$dumpvars (0,controlunit_test);	
			
			#4;
			br_less_i = 1'b0;
			br_equal_i = 1'b0;
			instr_i = 32'b0000000_01010_10011_000_10010_0110011; //adđ x18,x19,x10
			$display("test case 1: add x18,x19,x10");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b0100000_01010_10011_000_10010_0110011; //sub x18,x19,x10
			$display("test case 2: sub x18,x19,x10");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b000000000101_00110_000_00010_0010011; //addi x2,x6,5
			$display("test case 3: addi x2,x6,5");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b000000001111_00110_110_00010_0010011; //ori x2,x6,15
			$display("test case 3: ori x2,x6,15");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b0000000_00001_00110_110_00010_0010011; //slli x2,x6,1
			$display("test case 4: slli x2,x6,1");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b0100000_00001_00110_101_00010_0010011; //srai x2,x6,1
			$display("test case 5: srai x2,x6,1");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b000000001000_00010_010_01110_0000011; //lw x14,8(x2)
			$display("test case 6: lw x14,8(x2)");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b11111111111111111111111111111111; //false
			$display("test case 7: false");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 1;
			br_equal_i = 0;
			instr_i = 32'b0100000_00010_00011_100_10010_1100011; //blt x3,x2,521
			$display("test case 8: blt x3,x2,521");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b0100000_00010_00011_110_10010_1100011; //bltu x3,x2,521
			$display("test case 9: bltu x3,x2,521");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			#10;
			br_less_i = 0;
			br_equal_i = 0;
			instr_i = 32'b11111111111111111111111111111111; //false
			$display("test case 10: false");
			$display("instr_i=%b, br_less_i=%b, br_equal_i=%b", instr_i, br_less_i, br_equal_i);
			
			$finish;	
			
	end
	
		always @(posedge clk)
		$display ("(TIME=%t)  br_sel_o=%b, rd_wren_o=%b, br_unsigned_o=%b, op_a_sel_o=%b, op_b_sel_o=%b, alu_op_o=%b, mem_wren_o=%b, wb_sel_o=%b", $time, br_sel_o, rd_wren_o, br_unsigned_o, op_a_sel_o, op_b_sel_o, alu_op_o, mem_wren_o, wb_sel_o);
endmodule

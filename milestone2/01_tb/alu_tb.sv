module alu_tb;
    // Khai báo biến kết nối với thiết kế ALU
    logic [31:0] operand_a_i;
    logic [31:0] operand_b_i;
    logic [3:0] alu_op_i;
    logic [31:0] alu_data_o;

    // Instantiate thiết kế ALU và kết nối biến
    alu dut (
        .operand_a_i(operand_a_i),
        .operand_b_i(operand_b_i),
        .alu_op_i(alu_op_i),
        .alu_data_o(alu_data_o)
    );

task tk_expect (
	input logic [31:0] alu_x
);
	$display("[%4d] operand_a = %32b, operand_b = %32b, alu_op = %4b, alu_data = %32b, alu_x = %32b", $time, operand_a_i, operand_b_i, alu_op_i, alu_data_o, alu_x);
	
	assert (alu_data_o == alu_x) else begin
		$display("TEST FAILED");
		$stop;
		end
endtask


    // Tạo giá trị và kiểm tra kết quả
    initial begin
        operand_a_i = 10; // chọn operand_a_i là 10
        operand_b_i = 5;  // chọn operand_b_i là 5

        // Phép toán ADD
        alu_op_i = 4'b0000;
        #10 tk_expect(32'hf);
        //10 + 5 = 15

        #10
        // Phép toán SUB
        alu_op_i = 4'b0001;
        #10 tk_expect(32'h5);
        // 10 - 5 = 5
 
			
		    // Phép toán SLT
		    alu_op_i = 4'b0010;
		    #10 tk_expect(32'b0);
		    //0 (10 không nhỏ hơn 5)

        #10;
		    // Phép toán SLTU
		    alu_op_i = 4'b0011;
		    #10 tk_expect(32'b0);
		    #10;
		    //0 (10 không nhỏ hơn 5)


		    // Phép toán XOR
		    alu_op_i = 4'b0100;
		    #10 tk_expect(32'b1111);
		    #10;
		    //1010 XOR 0101 = 1111

		
		    // Phép toán OR
		    alu_op_i = 4'b0101;
		    #10 tk_expect(32'b1111);
		    #10;
		    //1010 OR 0101 = 1111
 

		    // Phép toán AND
		    alu_op_i = 4'b0110;
		    #10 tk_expect(32'b0);
		    #10;
		    //1010 AND 0101 = 0000


		    // Phép toán SLL
		    alu_op_i = 4'b0111;
		    #10 tk_expect(32'h140);
		    #10;
		    //10 << 5 = 320



		    // Phép toán SRL
		    alu_op_i = 4'b1000;
		    #10 tk_expect(32'b0);
        #10;
		    //10 >> 5 = 0
 

		    // Phép toán SRA
		    alu_op_i = 4'b1001;
		    #10 tk_expect(32'b0);
		    #10;
		    //10 >>> 5 
        
        //Phep toan LUI
        alu_op_i = 4'b1111;
        #10 tk_expect(32'h5000);
        #10;

        // Phep toan AUIPC

        alu_op_i = 4'b1110;
        #10 tk_expect(32'h500A);
        #10;
		    $display("TEST PASSED");
		    $finish;
      end
endmodule

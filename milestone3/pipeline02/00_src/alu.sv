`timescale 1ns/10ps

module alu 

	(
	//inputs
	input logic [31:0] operand_a_i,
	input logic [31:0] operand_b_i,
	input logic [3:0] alu_op_i,
	//outputs
	output logic [31:0] alu_data_o);
	

    logic [31:0] subtemp;
    assign subtemp = operand_a_i + (~operand_b_i + 1);
	 
	 
	always_comb begin
		case(alu_op_i)
			4'b0000: alu_data_o = operand_a_i + operand_b_i;																			// ADD
			4'b0001: alu_data_o = operand_a_i + ~operand_b_i+1;																		// SUB 	
			4'b0010: if(operand_a_i[31]==1 && operand_b_i[31]==0) 																	// SLT
					alu_data_o = 1;
				else begin
					if((operand_a_i[31]==1 && operand_b_i[31]==1)||(operand_a_i[31]==0 && operand_b_i[31]==0)) 
						begin
				    		if(subtemp[31]) 
								alu_data_o = 1;
							else 
								alu_data_o = 0;
						end
					else 
						alu_data_o = 0;
				end
			4'b0011: 																																// SLTU 
			if(subtemp[31]) 
					alu_data_o = 1;
				else 
					alu_data_o = 0;
			4'b0100: alu_data_o = operand_a_i^operand_b_i;																												//XOR
			4'b0101:  alu_data_o = operand_a_i|operand_b_i;																												// OR
			4'b0110: alu_data_o = operand_a_i&operand_b_i;																												// AND 
			
			
			4'b0111: begin
			case (operand_b_i)
			32'b00000 : alu_data_o = {operand_a_i[31:0]};
			32'b00001 : alu_data_o = {operand_a_i[30:0],1'b0};
			32'b00010 : alu_data_o = {operand_a_i[29:0],2'b0};
			32'b00011 : alu_data_o = {operand_a_i[28:0],3'b0};
			32'b00100 : alu_data_o = {operand_a_i[27:0],4'b0};
			32'b00101 : alu_data_o = {operand_a_i[26:0],5'b0};
			32'b00110 : alu_data_o = {operand_a_i[25:0],6'b0};
			32'b00111 : alu_data_o = {operand_a_i[24:0],7'b0};
			32'b01000 : alu_data_o = {operand_a_i[23:0],8'b0};
			32'b01001 : alu_data_o = {operand_a_i[22:0],9'b0};
			32'b01010 : alu_data_o = {operand_a_i[21:0],10'b0};
			32'b01011 : alu_data_o = {operand_a_i[20:0],11'b0};
			32'b01100 : alu_data_o = {operand_a_i[19:0],12'b0};
			32'b01101 : alu_data_o = {operand_a_i[18:0],13'b0};
			32'b01110 : alu_data_o = {operand_a_i[17:0],14'b0};
			32'b01111 : alu_data_o = {operand_a_i[16:0],15'b0};
			32'b10000 : alu_data_o = {operand_a_i[15:0],16'b0};
			32'b10001 : alu_data_o = {operand_a_i[14:0],17'b0};
			32'b10010 : alu_data_o = {operand_a_i[13:0],18'b0};
			32'b10011 : alu_data_o = {operand_a_i[12:0],19'b0};
			32'b10100 : alu_data_o = {operand_a_i[11:0],20'b0};
			32'b10101 : alu_data_o = {operand_a_i[10:0],21'b0};
			32'b10110 : alu_data_o = {operand_a_i[9:0],22'b0};
			32'b10111 : alu_data_o = {operand_a_i[8:0],23'b0};
			32'b11000 : alu_data_o = {operand_a_i[7:0],24'b0};
			32'b11001 : alu_data_o = {operand_a_i[6:0],25'b0};
			32'b11010 : alu_data_o = {operand_a_i[5:0],26'b0};
			32'b11011 : alu_data_o = {operand_a_i[4:0],27'b0};
			32'b11100 : alu_data_o = {operand_a_i[3:0],28'b0};
			32'b11101 : alu_data_o = {operand_a_i[2:0],29'b0};
			32'b11110 : alu_data_o = {operand_a_i[1:0],30'b0};
			32'b11111 : alu_data_o = {operand_a_i[0:0],31'b0};
			default: alu_data_o = 32'b0;
	endcase
	end


			4'b1000: begin
			case (operand_b_i)
			32'b00000 : alu_data_o = {operand_a_i[31:0]};
			32'b00001 : alu_data_o = {1'b0, operand_a_i[31:1]};
			32'b00010 : alu_data_o = {2'b0, operand_a_i[31:2]};
			32'b00011 : alu_data_o = {3'b0, operand_a_i[31:3]};
			32'b00100 : alu_data_o = {4'b0, operand_a_i[31:4]};
			32'b00101 : alu_data_o = {5'b0, operand_a_i[31:5]};
			32'b00110 : alu_data_o = {6'b0, operand_a_i[31:6]};
			32'b00111 : alu_data_o = {7'b0, operand_a_i[31:7]};
			32'b01000 : alu_data_o = {8'b0, operand_a_i[31:8]};
			32'b01001 : alu_data_o = {9'b0, operand_a_i[31:9]};
			32'b01010 : alu_data_o = {10'b0, operand_a_i[31:10]};
			32'b01011 : alu_data_o = {11'b0, operand_a_i[31:11]};
			32'b01100 : alu_data_o = {12'b0, operand_a_i[31:12]};
			32'b01101 : alu_data_o = {13'b0, operand_a_i[31:13]};
			32'b01110 : alu_data_o = {14'b0, operand_a_i[31:14]};
			32'b01111 : alu_data_o = {15'b0, operand_a_i[31:15]};
			32'b10000 : alu_data_o = {16'b0, operand_a_i[31:16]};
			32'b10001 : alu_data_o = {17'b0, operand_a_i[31:17]};
			32'b10010 : alu_data_o = {18'b0, operand_a_i[31:18]};
			32'b10011 : alu_data_o = {19'b0, operand_a_i[31:19]};
			32'b10100 : alu_data_o = {20'b0, operand_a_i[31:20]};
			32'b10101 : alu_data_o = {21'b0, operand_a_i[31:21]};
			32'b10110 : alu_data_o = {22'b0, operand_a_i[31:22]};
			32'b10111 : alu_data_o = {23'b0, operand_a_i[31:23]};
			32'b11000 : alu_data_o = {24'b0, operand_a_i[31:24]};
			32'b11001 : alu_data_o = {25'b0, operand_a_i[31:25]};
			32'b11010 : alu_data_o = {26'b0, operand_a_i[31:26]};
			32'b11011 : alu_data_o = {27'b0, operand_a_i[31:27]};
			32'b11100 : alu_data_o = {28'b0, operand_a_i[31:28]};
			32'b11101 : alu_data_o = {29'b0, operand_a_i[31:29]};
			32'b11110 : alu_data_o = {30'b0, operand_a_i[31:30]};
			32'b11111 : alu_data_o = {31'b0, operand_a_i[31:31]};
			default: alu_data_o = 32'b0;

	endcase
	end

			// SRL
			4'b1001: if (operand_a_i[31] == 0 )	
			begin
			case (operand_b_i)
			32'b00000 : alu_data_o = {operand_a_i[31:0]};
			32'b00001 : alu_data_o = {1'b0, operand_a_i[31:1]};
			32'b00010 : alu_data_o = {2'b0, operand_a_i[31:2]};
			32'b00011 : alu_data_o = {3'b0, operand_a_i[31:3]};
			32'b00100 : alu_data_o = {4'b0, operand_a_i[31:4]};
			32'b00101 : alu_data_o = {5'b0, operand_a_i[31:5]};
			32'b00110 : alu_data_o = {6'b0, operand_a_i[31:6]};
			32'b00111 : alu_data_o = {7'b0, operand_a_i[31:7]};
			32'b01000 : alu_data_o = {8'b0, operand_a_i[31:8]};
			32'b01001 : alu_data_o = {9'b0, operand_a_i[31:9]};
			32'b01010 : alu_data_o = {10'b0, operand_a_i[31:10]};
			32'b01011 : alu_data_o = {11'b0, operand_a_i[31:11]};
			32'b01100 : alu_data_o = {12'b0, operand_a_i[31:12]};
			32'b01101 : alu_data_o = {13'b0, operand_a_i[31:13]};
			32'b01110 : alu_data_o = {14'b0, operand_a_i[31:14]};
			32'b01111 : alu_data_o = {15'b0, operand_a_i[31:15]};
			32'b10000 : alu_data_o = {16'b0, operand_a_i[31:16]};
			32'b10001 : alu_data_o = {17'b0, operand_a_i[31:17]};
			32'b10010 : alu_data_o = {18'b0, operand_a_i[31:18]};
			32'b10011 : alu_data_o = {19'b0, operand_a_i[31:19]};
			32'b10100 : alu_data_o = {20'b0, operand_a_i[31:20]};
			32'b10101 : alu_data_o = {21'b0, operand_a_i[31:21]};
			32'b10110 : alu_data_o = {22'b0, operand_a_i[31:22]};
			32'b10111 : alu_data_o = {23'b0, operand_a_i[31:23]};
			32'b11000 : alu_data_o = {24'b0, operand_a_i[31:24]};
			32'b11001 : alu_data_o = {25'b0, operand_a_i[31:25]};
			32'b11010 : alu_data_o = {26'b0, operand_a_i[31:26]};
			32'b11011 : alu_data_o = {27'b0, operand_a_i[31:27]};
			32'b11100 : alu_data_o = {28'b0, operand_a_i[31:28]};
			32'b11101 : alu_data_o = {29'b0, operand_a_i[31:29]};
			32'b11110 : alu_data_o = {30'b0, operand_a_i[31:30]};
			32'b11111 : alu_data_o = {31'b0, operand_a_i[31:31]};
			default: alu_data_o = 32'b0;

	endcase
	end
			else
			begin
			case (operand_b_i)
			32'b00000 : alu_data_o = {operand_a_i[31:0]};
			32'b00001 : alu_data_o = {1'b1, operand_a_i[31:1]};
			32'b00010 : alu_data_o = {2'b11, operand_a_i[31:2]};
			32'b00011 : alu_data_o = {3'b111, operand_a_i[31:3]};
			32'b00100 : alu_data_o = {4'b1111, operand_a_i[31:4]};
			32'b00101 : alu_data_o = {5'b11111, operand_a_i[31:5]};
			32'b00110 : alu_data_o = {6'b111111, operand_a_i[31:6]};
			32'b00111 : alu_data_o = {7'b1111111, operand_a_i[31:7]};
			32'b01000 : alu_data_o = {8'b11111111, operand_a_i[31:8]};
			32'b01001 : alu_data_o = {9'b111111111, operand_a_i[31:9]};
			32'b01010 : alu_data_o = {10'b1111111111, operand_a_i[31:10]};
			32'b01011 : alu_data_o = {11'b11111111111, operand_a_i[31:11]};
			32'b01100 : alu_data_o = {12'b111111111111, operand_a_i[31:12]};
			32'b01101 : alu_data_o = {13'b1111111111111, operand_a_i[31:13]};
			32'b01110 : alu_data_o = {14'b11111111111111, operand_a_i[31:14]};
			32'b01111 : alu_data_o = {15'b111111111111111, operand_a_i[31:15]};
			32'b10000 : alu_data_o = {16'b1111111111111111, operand_a_i[31:16]};
			32'b10001 : alu_data_o = {17'b11111111111111111, operand_a_i[31:17]};
			32'b10010 : alu_data_o = {18'b111111111111111111, operand_a_i[31:18]};
			32'b10011 : alu_data_o = {19'b1111111111111111111, operand_a_i[31:19]};
			32'b10100 : alu_data_o = {20'b11111111111111111111, operand_a_i[31:20]};
			32'b10101 : alu_data_o = {21'b111111111111111111111, operand_a_i[31:21]};
			32'b10110 : alu_data_o = {22'b1111111111111111111111, operand_a_i[31:22]};
			32'b10111 : alu_data_o = {23'b11111111111111111111111, operand_a_i[31:23]};
			32'b11000 : alu_data_o = {24'b111111111111111111111111, operand_a_i[31:24]};
			32'b11001 : alu_data_o = {25'b1111111111111111111111111, operand_a_i[31:25]};
			32'b11010 : alu_data_o = {26'b11111111111111111111111111, operand_a_i[31:26]};
			32'b11011 : alu_data_o = {27'b111111111111111111111111111, operand_a_i[31:27]};
			32'b11100 : alu_data_o = {28'b1111111111111111111111111111, operand_a_i[31:28]};
			32'b11101 : alu_data_o = {29'b11111111111111111111111111111, operand_a_i[31:29]};
			32'b11110 : alu_data_o = {30'b111111111111111111111111111111, operand_a_i[31:30]};
			32'b11111 : alu_data_o = {31'b1111111111111111111111111111111, operand_a_i[31:31]};
			default: alu_data_o = 32'b0;

	endcase
	end
			4'b1111: alu_data_o = operand_b_i;																																// LUI
			default: alu_data_o = 32'b0;
		endcase
	end
endmodule : alu

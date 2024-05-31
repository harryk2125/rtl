`timescale 1ns/10ps

// Main program:
module brcomp
#(
	parameter data_width = 32
)
(
// Inputs - Output:
	input logic [data_width-1:0] rs1_data_i,
	input logic [data_width-1:0] rs2_data_i,
	input logic br_unsigned_i,
	output logic br_less_o,
	output logic br_equal_o
);

// Variables
logic lwt, eql, neg1, neg2; 	// lower - equal - negative_rs1 - negative_rs2 variables
logic [data_width-1:0] temp_num1, n1;
logic [data_width-1:0] temp_num2, n2;
logic [1:0] status;				// status = {neg1,neg2}

// If it is signed number and negative => neg(1-2) = 1 else 0
assign neg1 = ((br_unsigned_i == 0) && (rs1_data_i[31] == 1)) ? 1 : 0;
assign neg2 = ((br_unsigned_i == 0) && (rs2_data_i[31] == 1)) ? 1 : 0;

assign status = {neg1,neg2};

two_comp2bin pos_bin1(
	.two_comp_num	(rs1_data_i),
	.bin_num			(temp_num1)
);

two_comp2bin pos_bin2(
	.two_comp_num	(rs2_data_i),
	.bin_num			(temp_num2)
);

// Unsigned -> Keep (rs_data) ; signed -> get temp_num 
assign n1 = (br_unsigned_i == 1) ? rs1_data_i : temp_num1;
assign n2 = (br_unsigned_i == 1) ? rs2_data_i : temp_num2;

// Implement compare 2 number:
compare comp(
	.num1		(n1),
	.num2		(n2),
	.less		(lwt),
	.equal	(eql)
);

// Result for each case:
always_comb begin
	case (br_unsigned_i)              
		1'b1: begin                         // Unsigned
			br_less_o = lwt;
			br_equal_o = eql;
			end
		1'b0: begin                         // Signed
			case (status)
				2'b00: begin                    // Positive - Positive 
					br_less_o = lwt;
					br_equal_o = eql;
				end
				2'b01: begin                    // Positive - Negative
					br_less_o = 1'b0;
					br_equal_o = 1'b0;
				end
				2'b10: begin                    // Negative - Positive
					br_less_o = 1'b1;
					br_equal_o = 1'b0;
				end
				2'b11: begin                    // Negative - Negative
					br_less_o = ~lwt ^ eql;       // Make sure give only br_less = 1 if br_equal = 0
					br_equal_o = eql;
				end
			endcase
			end
	endcase
end

endmodule

// Module: compare 2 unsigned 32 bit-data
module compare
#(
	parameter data_width = 32
)
(
	input logic [data_width-1:0] num1,
	input logic [data_width-1:0] num2,
	output logic less,
	output logic equal
);

logic [data_width-1:0] temp_num;

assign temp_num = num1 + ~num2 + 1;                                                      // num1 - num2
 
assign equal = (num1 == num2) ? 1 : 0;                                                   // equal     
assign less = ((num1[31] == 1) && (num2[31] == 0)) ? 0 : ((temp_num[31] == 1) ? 1 : 0);  // less 

endmodule: compare

// Convert negative 2's complement into positive
module two_comp2bin(
	input logic [31:0] two_comp_num,
	output logic [31:0] bin_num
);

wire [31:0] temp_num, neg_num;

assign neg_num = ~two_comp_num + 1;
assign temp_num = (two_comp_num[31] == 1) ? neg_num : two_comp_num;
assign bin_num[31] = temp_num[31];
assign bin_num[30:0] = (temp_num[30:0] ^ temp_num[31]) ^ temp_num[31];

endmodule: two_comp2bin

module BCD_Adder_8_bit
	(input logic[7:0]	A, B,
	input logic			Cin,
	output logic[7:0]	S,
	output logic		Cout);
	
	logic				Cout_intermediate;
	
	
	Adder_4_bit LowDigit(A[3:0], B[3:0], Cin, S[3:0], Cout_intermediate);
	Adder_4_bit HighDigit(A[7:4], B[7:4], Cout_intermediate, S[7:4], Cout);

endmodule

module Adder_4_bit
	(input logic[3:0]	A, B,
	input logic			Cin,
	output logic[3:0]	S,
	output logic		Cout);
	
	logic[4:0]			Sum;
	
	
	assign Sum = A + B + Cin;
	
	assign S = Sum[3:0];
	assign Cout = Sum[4];

endmodule

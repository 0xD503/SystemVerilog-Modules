module Bus_Spliter
	#(parameter	N = 8,
	parameter	in_A_WIDTH = 4,
	parameter	in_B_WIDTH = 4)
	
	(input logic[(in_A_WIDTH - 1):0]	in_A,
	input logic[(in_B_WIDTH - 1):0]	in_B,
	output logic[(N - 1):0]				out_A);
	
	assign out_A[(N - 1):(N - in_A_WIDTH)]	= in_A;
	assign out_A[(in_B_WIDTH - 1):(0)]		= in_B;

endmodule

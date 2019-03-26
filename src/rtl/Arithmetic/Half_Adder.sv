module Half_Adder
	(input logic	i_A, i_B,
	output logic	o_Sum,
	output logic	o_Cout);

	assign o_Sum = i_A ^ i_B;
	assign o_Cout = i_A & i_B;
	
endmodule

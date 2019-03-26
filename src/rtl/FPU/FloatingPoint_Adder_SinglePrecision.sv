module FloatingPoint_Adder_SinglePrecision
	(input logic[31:0]	i_A, i_B,
	output logic[31:0]	o_S);
	
	logic		s_SignA, s_SignB, s_Sign;
	
	logic[23:0]	s_MantissaA, s_MantissaB;
	logic[22:0]	s_Mantissa;
	logic[23:0]	s_ShiftedMantissa, s_UnshiftedMantissa;
	//logic[7:0]	s_shamt;
	
	logic[7:0]	s_ExpA, s_ExpB, s_UnshiftedExponent, s_Exponent;
	logic[7:0]	s_Difference;
	logic		s_AmoreOrEqualB;
	
	
	assign s_SignA = i_A[31];
	assign s_SignB = i_B[31];
	
	assign s_ExpA = i_A[30:23];
	assign s_ExpB = i_B[30:23];
	
	assign s_MantissaA = {1'b1, i_A[22:0]};
	assign s_MantissaB = {1'b1, i_B[22:0]};
	
	
	Exponent_Comparator Exp_Compare(s_ExpA, s_ExpB, s_AmoreOrEqualB, s_Difference, s_UnshiftedExponent);
	
	MantissaShifter Mantissa_Shifter (s_MantissaA, s_MantissaB, s_Difference, s_AmoreOrEqualB, s_ShiftedMantissa, s_UnshiftedMantissa);
	
	MantissaAdderAndNormalizer Mantisses_Adder (s_ShiftedMantissa, s_UnshiftedMantissa, s_UnshiftedExponent, s_SignA, s_SignB, s_AmoreOrEqualB, s_Sign, s_Exponent, s_Mantissa);
	
	
	assign o_S = {s_Sign, s_Exponent, s_Mantissa};

endmodule


module Exponent_Comparator
	(input logic[7:0]	i_ExpA, i_ExpB,
	output logic		o_AmoreOrEqualB,
	output logic[7:0]	o_Difference,
	output logic[7:0]	o_Exp);
	
	
	always_comb
	begin
		if (i_ExpA >= i_ExpB)
		begin
			o_Exp = i_ExpA;
			o_Difference = i_ExpA - i_ExpB;
			o_AmoreOrEqualB = 1'b1;
		end
		else
		begin
			o_Exp = i_ExpB;
			o_Difference = i_ExpB - i_ExpA;
			o_AmoreOrEqualB = 1'b0;
		end
	end
	
endmodule


module MantissaShifter
	(input logic[23:0]	i_MantissaA, i_MantissaB,
	input logic[7:0]	i_shamt,
	input logic			i_AmoreOrEqualB,
	output logic[23:0]	o_ShiftedMantissa, o_UnshiftedMantissa);
	
	logic[23:0]			s_ShiftedMantissa;
	
	assign s_ShiftedMantissa = i_AmoreOrEqualB ?	(i_MantissaB >> i_shamt) : (i_MantissaA >> i_shamt);
	assign o_UnshiftedMantissa = i_AmoreOrEqualB ?	i_MantissaA : i_MantissaB;
	
	always_comb
	begin
		if (i_shamt[7] | i_shamt[6] | i_shamt[5] | (i_shamt[4] && i_shamt[3]))	o_ShiftedMantissa = 24'b0;
		else															o_ShiftedMantissa = s_ShiftedMantissa;
	end
	
endmodule


module MantissaAdderAndNormalizer
	(input logic[23:0]	i_ShiftedMantissa, i_UnshiftedMantissa,
	input logic[7:0]	i_Exp,
	input logic			i_SignA, i_SignB,
	input logic			i_AmoreOrEqualB,
	output logic		o_Sign,
	output logic[7:0]	o_Exp,
	output logic[22:0]	o_FractionPart);
	
	logic[24:0]			v_Temp;
	logic[23:0]			s_MantissaA, s_MantissaB;
	

	always_comb
	begin
		if (i_AmoreOrEqualB == 1'b1)
		begin
			s_MantissaA = i_UnshiftedMantissa;
			s_MantissaB = i_ShiftedMantissa;
		end
		else
		begin
			s_MantissaA = i_ShiftedMantissa;
			s_MantissaB = i_UnshiftedMantissa;
		end
		
		if (i_SignA != i_SignB)
		begin
			if (i_SignA == 1'b0)	v_Temp = s_MantissaA - s_MantissaB;
			else					v_Temp = s_MantissaB - s_MantissaA;
			if (v_Temp < 0)			o_Sign = 1'b1;
			else					o_Sign = 1'b0;
		end
		else
		begin
			v_Temp = s_MantissaA + s_MantissaB;
			if (i_SignA == 1'b0)	o_Sign = 1'b0;
			else					o_Sign = 1'b1;
		end
	end
	
	assign o_FractionPart = v_Temp[24] ?	v_Temp[23:1] : v_Temp[22:0];
	assign o_Exp = v_Temp[24] ?				(i_Exp + 1'd1) : i_Exp;

endmodule

module FloatingPoint_Multiplier_SinglePrecision
	(input logic[31:0]	i_Factor1, i_Factor2,
	output logic[31:0]	o_Product);

	logic		s_SignA, s_SignB;
	logic		s_Sign;
	
	logic[7:0]	s_ExpA, s_ExpB;
	logic[7:0]	s_TempExp;
	logic[7:0]	s_Exp;
	
	logic[23:0]	s_MantissaA, s_MantissaB;
	logic[47:0]	s_Product;
	logic[22:0]	s_Fraction;
	
	assign s_SignA = i_Factor1[31];
	assign s_SignB = i_Factor2[31];
	
	assign s_ExpA = i_Factor1[30:23];
	assign s_ExpB = i_Factor2[30:23];
	
	assign s_MantissaA = {1'b1, i_Factor1[22:0]};
	assign s_MantissaB = {1'b1, i_Factor2[22:0]};
	
	assign s_TempExp = s_ExpA + s_ExpB;
	assign s_Product = s_MantissaA * s_MantissaB;
	
	
	assign s_Sign = (s_SignA == s_SignB) ?	1'b0 : 1'b1;
	assign s_Exp = (s_Product[47]) ?	(s_TempExp - 8'd126) : (s_TempExp - 8'd127);
	assign s_Fraction = (s_Product[47]) ?	s_Product[46:24] : s_Product[45:23];
	
	assign o_Product = {s_Sign, s_Exp, s_Fraction};

endmodule

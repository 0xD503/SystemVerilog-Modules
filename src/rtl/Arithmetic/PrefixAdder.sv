module PrefixAdder
	(input logic[15:0]	A, B,
	input logic			Cin,
	output logic[15:0]	S,
	output logic		Cout);

	logic[15:0]			P, G;
	
	logic[7:0]			Pik_0, Pkj_0, Gik_0, Gkj_0,
						Pik_1, Pkj_1, Gik_1, Gkj_1,
						Pik_2, Pkj_2, Gik_2, Gkj_2,
						Pik_3, Pkj_3, Gik_3, Gkj_3,
	
						Pij_0, Gij_0,
						Pij_1, Gij_1,
						Pij_2, Gij_2,
						Gij_3;

	logic[7:0]			prop;
	logic[15:0]			generateSignal;



	PG_Block_SV in(A[14:0], B[14:0], P, G);
	
	assign Pik_0 = {P[14], P[12], P[10], P[8], P[6], P[4], P[2], P[0]};
	assign Gik_0 = {G[14], G[12], G[10], G[8], G[6], G[4], G[2], G[0]};
	
	assign Pkj_0 = {P[13], P[11], P[9], P[7], P[5], P[3], P[1], 1'b0};
	assign Gkj_0 = {G[13], G[11], G[9], G[7], G[5], G[3], G[1], Cin};

	
	BlackCell_SV topLevel	(Pik_0, Pkj_0, Gik_0, Gkj_0, Pij_0, Gij_0);
	
	assign Pik_1 = {Pij_0[7], P[13], Pij_0[5], P[9], Pij_0[3], P[5], Pij_0[1], P[1]};
	assign Gik_1 = {Gij_0[7], G[13], Gij_0[5], G[9], Gij_0[3], G[5], Gij_0[1], G[1]};
	
	assign Pkj_1 = {Pij_0[6], Pij_0[6], Pij_0[4], Pij_0[4], Pij_0[2], Pij_0[2], Pij_0[0], Pij_0[0]};
	assign Gkj_1 = {Gij_0[6], Gij_0[6], Gij_0[4], Gij_0[4], Gij_0[2], Gij_0[2], Gij_0[0], Gij_0[0]};
	
	BlackCell_SV secondLevel(Pik_1, Pkj_1, Gik_1, Gkj_1, Pij_1, Gij_1);
	
	assign Pik_2 = {Pij_1[7], Pij_1[6], Pij_0[6], P[11], Pij_1[3], Pij_1[2], Pij_0[2], P[3]};
	assign Gik_2 = {Gij_1[7], Gij_1[6], Gij_0[6], G[11], Gij_1[3], Gij_1[2], Gij_0[2], G[3]};
	
	assign Pkj_2 = {Pij_1[5], Pij_1[5], Pij_1[5], Pij_1[5], Pij_1[1], Pij_1[1], Pij_1[1], Pij_1[1]};
	assign Gkj_2 = {Gij_1[5], Gij_1[5], Gij_1[5], Gij_1[5], Gij_1[1], Gij_1[1], Gij_1[1], Gij_1[1]};
	
	BlackCell_SV thirdLevel	(Pik_2, Pkj_2, Gik_2, Gkj_2, Pij_2, Gij_2);
	
	assign Pik_3 = {Pij_2[7], Pij_2[6], Pij_2[5], Pij_2[4], Pij_1[5], Pij_1[4], Pij_0[4], P[7]};
	assign Gik_3 = {Gij_2[7], Gij_2[6], Gij_2[5], Gij_2[4], Gij_1[5], Gij_1[4], Gij_0[4], G[7]};
	
	assign Pkj_3 = {Pij_2[3], Pij_2[3], Pij_2[3], Pij_2[3], Pij_2[3], Pij_2[3], Pij_2[3], Pij_2[3]};
	assign Gkj_3 = {Gij_2[3], Gij_2[3], Gij_2[3], Gij_2[3], Gij_2[3], Gij_2[3], Gij_2[3], Gij_2[3]};

	BlackCell_SV bottomLevel(Pik_3, Pkj_3, Gik_3, Gkj_3, prop, Gij_3);
	
	assign generateSignal =	{Gij_3[7], Gij_3[6], Gij_3[5], Gij_3[4], Gij_3[3], Gij_3[2], Gij_3[1], Gij_3[0],
						Gij_2[3], Gij_2[2], Gij_2[1], Gij_2[0],
						Gij_1[1], Gij_1[0],
						Gij_0[0],
						Cin};

	SumBlock_SV out(A, B, generateSignal, S);


	assign Cout = (A[15] & B[15]) || (generateSignal && (A[15] | B[15]));

endmodule

module PG_Block
	(input logic[14:0]	A, B,
	output logic[14:0]	P, G);

	assign P = A | B;
	assign G = A & B;

endmodule

module BlackCell
	(input logic[7:0]	Pik, Pkj, Gik, Gkj,
	output logic[7:0]	Pij, Gij);

	logic[7:0]			PikGkj;

	assign PikGkj = Pik & Gkj;
	
	assign Pij = Pik & Pkj;
	assign Gij = Gik | PikGkj;

endmodule

module SumBlock
	(input logic[15:0]	A, B, G,
	output logic[15:0]	S);
	
	assign S = A ^ B ^ G;

endmodule

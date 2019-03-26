module CarryPrefix_Adder
	(input logic[31:-1]	i_A, i_B,
	input logic			i_Cin,
	output logic[31:0]	o_Sum,
	output logic		o_Cout);

	logic[31:-1]	s_Pi, s_Gi;



	logic[15:0] s_Pik_0, s_Pkj_0, s_Gik_0, s_Gkj_0,
				s_Pik_1, s_Pkj_1, s_Gik_1, s_Gkj_1,
				s_Pik_2, s_Pkj_2, s_Gik_2, s_Gkj_2,
				s_Pik_3, s_Pkj_3, s_Gik_3, s_Gkj_3,
				s_Pik_4, s_Pkj_4, s_Gik_4, s_Gkj_4;

	logic[15:0]	s_Pij_0, s_Gij_0,
				s_Pij_1, s_Gij_1,
				s_Pij_2, s_Gij_2,
				s_Pij_3, s_Gij_3,
				s_Pij_4, s_Gij_4;


	logic[30:0]	s_Propagate, s_Generate;



	PropagateGenerate_Block in(i_A, i_B, s_Pi, s_Gi);
	
	assign s_Pik_0 = {s_Pi[30], s_Pi[28], s_Pi[26], s_Pi[24], s_Pi[22], s_Pi[20], s_Pi[18], s_Pi[16], s_Pi[14], s_Pi[12], s_Pi[10], s_Pi[8], s_Pi[6], s_Pi[4], s_Pi[2], s_Pi[0]};
	assign s_Gik_0 = {s_Gi[30], s_Gi[28], s_Gi[26], s_Gi[24], s_Gi[22], s_Gi[20], s_Gi[18], s_Gi[16], s_Gi[14], s_Gi[12], s_Gi[10], s_Gi[8], s_Gi[6], s_Gi[4], s_Gi[2], s_Gi[0]};

	assign s_Pkj_0 = {s_Pi[29], s_Pi[27], s_Pi[25], s_Pi[23], s_Pi[21], s_Pi[19], s_Pi[17], s_Pi[15], s_Pi[13], s_Pi[11], s_Pi[9], s_Pi[7], s_Pi[5], s_Pi[3], s_Pi[1], 1'b0/*s_Pi[-1]*/};
	assign s_Gkj_0 = {s_Gi[29], s_Gi[27], s_Gi[25], s_Gi[23], s_Gi[21], s_Gi[19], s_Gi[17], s_Gi[15], s_Gi[13], s_Gi[11], s_Gi[9], s_Gi[7], s_Gi[5], s_Gi[3], s_Gi[1], i_Cin/*s_Gi[-1]*/};
	
	BlackBox_Block topLevel(s_Pik_0, s_Pkj_0, s_Gik_0, s_Gkj_0, s_Pij_0, s_Gij_0);
	
	
	assign s_Pik_1 = {s_Pij_0[15], s_Pi[29], s_Pij_0[13], s_Pi[25], s_Pij_0[11], s_Pi[21], s_Pij_0[9], s_Pi[17], s_Pij_0[7], s_Pi[13], s_Pij_0[5], s_Pi[9], s_Pij_0[3], s_Pi[5], s_Pij_0[1], s_Pi[1]};
	assign s_Gik_1 = {s_Gij_0[15], s_Gi[29], s_Gij_0[13], s_Gi[25], s_Gij_0[11], s_Gi[21], s_Gij_0[9], s_Gi[17], s_Gij_0[7], s_Gi[13], s_Gij_0[5], s_Gi[9], s_Gij_0[3], s_Gi[5], s_Gij_0[1], s_Gi[1]};

	assign s_Pkj_1 = {s_Pij_0[14], s_Pij_0[14], s_Pij_0[12], s_Pij_0[12], s_Pij_0[10], s_Pij_0[10], s_Pij_0[8], s_Pij_0[8], s_Pij_0[6], s_Pij_0[6], s_Pij_0[4], s_Pij_0[4], s_Pij_0[2], s_Pij_0[2], s_Pij_0[0], s_Pij_0[0]};
	assign s_Gkj_1 = {s_Gij_0[14], s_Gij_0[14], s_Gij_0[12], s_Gij_0[12], s_Gij_0[10], s_Gij_0[10], s_Gij_0[8], s_Gij_0[8], s_Gij_0[6], s_Gij_0[6], s_Gij_0[4], s_Gij_0[4], s_Gij_0[2], s_Gij_0[2], s_Gij_0[0], s_Gij_0[0]};
	
	BlackBox_Block secondLevel(s_Pik_1, s_Pkj_1, s_Gik_1, s_Gkj_1, s_Pij_1, s_Gij_1);
	
	
	assign s_Pik_2 = {s_Pij_1[15], s_Pij_1[14], s_Pij_0[14], s_Pi[27], s_Pij_1[11], s_Pij_1[10], s_Pij_0[10], s_Pi[19], s_Pij_1[7], s_Pij_1[6], s_Pij_0[6], s_Pi[11], s_Pij_1[3], s_Pij_1[2], s_Pij_0[2], s_Pi[3]};
	assign s_Gik_2 = {s_Gij_1[15], s_Gij_1[14], s_Gij_0[14], s_Gi[27], s_Gij_1[11], s_Gij_1[10], s_Gij_0[10], s_Gi[19], s_Gij_1[7], s_Gij_1[6], s_Gij_0[6], s_Gi[11], s_Gij_1[3], s_Gij_1[2], s_Gij_0[2], s_Gi[3]};

	assign s_Pkj_2 = {s_Pij_1[13], s_Pij_1[13], s_Pij_1[13], s_Pij_1[13], s_Pij_1[9], s_Pij_1[9], s_Pij_1[9], s_Pij_1[9], s_Pij_1[5], s_Pij_1[5], s_Pij_1[5], s_Pij_1[5], s_Pij_1[1], s_Pij_1[1], s_Pij_1[1], s_Pij_1[1]};
	assign s_Gkj_2 = {s_Gij_1[13], s_Gij_1[13], s_Gij_1[13], s_Gij_1[13], s_Gij_1[9], s_Gij_1[9], s_Gij_1[9], s_Gij_1[9], s_Gij_1[5], s_Gij_1[5], s_Gij_1[5], s_Gij_1[5], s_Gij_1[1], s_Gij_1[1], s_Gij_1[1], s_Gij_1[1]};
	
	BlackBox_Block thirdLevel(s_Pik_2, s_Pkj_2, s_Gik_2, s_Gkj_2, s_Pij_2, s_Gij_2);
	
	
	assign s_Pik_3 = {s_Pij_2[15], s_Pij_2[14], s_Pij_2[13], s_Pij_2[12], s_Pij_1[13], s_Pij_1[12], s_Pij_0[12], s_Pi[8], s_Pij_2[7], s_Pij_2[6], s_Pij_2[5], s_Pij_2[4], s_Pij_1[5], s_Pij_1[4], s_Pij_0[4], s_Pi[0]};
	assign s_Gik_3 = {s_Gij_2[15], s_Gij_2[14], s_Gij_2[13], s_Gij_2[12], s_Gij_1[13], s_Gij_1[12], s_Gij_0[12], s_Gi[8], s_Gij_2[7], s_Gij_2[6], s_Gij_2[5], s_Gij_2[4], s_Gij_1[5], s_Gij_1[4], s_Gij_0[4], s_Gi[0]};

	assign s_Pkj_3 = {s_Pij_2[11], s_Pij_2[11], s_Pij_2[11], s_Pij_2[11], s_Pij_2[11], s_Pij_2[11], s_Pij_2[11], s_Pij_2[11], s_Pij_2[7], s_Pij_2[7], s_Pij_2[7], s_Pij_2[7], s_Pij_2[7], s_Pij_2[7], s_Pij_2[7], s_Pij_2[7]};
	assign s_Gkj_3 = {s_Gij_2[11], s_Gij_2[11], s_Gij_2[11], s_Gij_2[11], s_Gij_2[11], s_Gij_2[11], s_Gij_2[11], s_Gij_2[11], s_Gij_2[7], s_Gij_2[7], s_Gij_2[7], s_Gij_2[7], s_Gij_2[7], s_Gij_2[7], s_Gij_2[7], s_Gij_2[7]};
	
	BlackBox_Block fourthLevel(s_Pik_3, s_Pkj_3, s_Gik_3, s_Gkj_3, s_Pij_3, s_Gij_3);
	
	
	assign s_Pik_4 = {s_Pij_3[15], s_Pij_3[14], s_Pij_3[13], s_Pij_3[12], s_Pij_3[11], s_Pij_3[10], s_Pij_3[9], s_Pij_3[8], s_Pij_2[11], s_Pij_2[10], s_Pij_2[9], s_Pij_2[8], s_Pij_1[9], s_Pij_1[8], s_Pij_0[8], s_Pi[15]};
	assign s_Gik_4 = {s_Gij_3[15], s_Gij_3[14], s_Gij_3[13], s_Gij_3[12], s_Gij_3[11], s_Gij_3[10], s_Gij_3[9], s_Gij_3[8], s_Gij_2[11], s_Gij_2[10], s_Gij_2[9], s_Gij_2[8], s_Gij_1[9], s_Gij_1[8], s_Gij_0[8], s_Gi[15]};

	assign s_Pkj_4 = {s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7], s_Pij_3[7]};
	assign s_Gkj_4 = {s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7], s_Gij_3[7]};
	
	BlackBox_Block bottomLevel(s_Pik_4, s_Pkj_4, s_Gik_4, s_Gkj_4, s_Pij_4, s_Gij_4);
	
	assign s_Propagate = {s_Pij_4, s_Pij_3[7:0], s_Pij_2[3:0], s_Pij_1[1:0], s_Pij_0[0]};
	assign s_Generate = {s_Gij_4, s_Gij_3[7:0], s_Gij_2[3:0], s_Gij_1[1:0], s_Gij_0[0]};
	
	Sum_Block out(i_A, i_B, s_Generate, o_Sum);

endmodule

module PropagateGenerate_Block
	(input logic[31:-1]	i_A, i_B,
	output logic[31:-1]	o_P, o_G);
	
	assign o_P[30:-1] = i_A[30:-1] | i_B[30:-1];
	assign o_G[30:-1] = i_A[30:-1] & i_B[30:-1];

endmodule

module BlackBox_Block
	(input logic[15:0]	i_Pik, i_Pkj, i_Gik, i_Gkj,
	output logic[15:0]	o_Pij, o_Gij);
	
	logic[15:0]			s_PikGkj;
	
	assign s_PikGkj = i_Pik & i_Gkj;
	
	assign o_Pij = i_Pik & i_Pkj;
	assign o_Gij = i_Gik | s_PikGkj;

endmodule

module Sum_Block
	(input logic[31:0]	i_A, i_B, i_Gprev,
	output logic[31:0]	o_S);

	assign o_S = i_A ^ i_B ^ i_Gprev;

endmodule
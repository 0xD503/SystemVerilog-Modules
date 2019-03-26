//	Kogge_Stone_Adder modules
module Kogge_Stone_Adder
	(input logic[3:0]	A, B,
	input logic			Cin,
	output logic[3:0]	S,
	output logic		Cout);
	
	logic[2:0]			yellowCircleIn_P, yellowCircleIn_Pprev, yellowCircleIn_G, yellowCircleIn_Gprev;
	logic[1:0]			whiteYellowCircleIn_P, whiteYellowCircleIn_Pprev, whiteYellowCircleIn_G, whiteYellowCircleIn_Gprev;
	
	logic[3:0]			redBoxOut_P, redBoxOut_G;
	logic[2:0]			yellowCircleOut_P, yellowCircleOut_G;
	logic[1:0]			whiteYellowCircleOut_P, whiteYellowCircleOut_G;
	
	logic[3:0]			carryOut;
	
	logic[3:0]			sum;
	
	RedBox in(A, B, redBoxOut_P, redBoxOut_G);
	
	assign yellowCircleIn_P = redBoxOut_P[3:1];
	assign yellowCircleIn_Pprev = redBoxOut_P[2:0];
	
	assign yellowCircleIn_G = redBoxOut_G[3:1];
	assign yellowCircleIn_Gprev = redBoxOut_G[2:0];
	
	YellowCircle topLevel(yellowCircleIn_P, yellowCircleIn_Pprev, yellowCircleIn_G, yellowCircleIn_Gprev, yellowCircleOut_P, yellowCircleOut_G);
	
	assign whiteYellowCircleIn_P = yellowCircleOut_P[2:1];
	assign whiteYellowCircleIn_Pprev = {yellowCircleOut_P[0], redBoxOut_P[0]};
	
	assign whiteYellowCircleIn_G = yellowCircleOut_G[2:1];
	assign whiteYellowCircleIn_Gprev = {yellowCircleOut_G[0], redBoxOut_G[0]};
	
	WhiteYellowCircle secondLevel(whiteYellowCircleIn_P, whiteYellowCircleIn_Pprev, whiteYellowCircleIn_G, whiteYellowCircleIn_Gprev, whiteYellowCircleOut_P, whiteYellowCircleOut_G);
	
	assign carryOut = {whiteYellowCircleOut_G, yellowCircleOut_G[0], redBoxOut_G[0]};
	assign sum[0] = redBoxOut_P[0] ^ Cin;
	assign sum[3:1] = redBoxOut_P[3:1] ^ carryOut[2:0];
	
	assign S = sum;
	assign Cout = carryOut[3];

endmodule

module RedBox
	(input logic[3:0]	A, B,
	output logic[3:0]	P, G);
	
	assign P = A ^ B;
	assign G = A & B;

endmodule

module YellowCircle
	(input logic[2:0]	Pi, Pprev, Gi, Gprev,
	output logic[2:0]	P, G);
	
	assign P = Pi & Pprev;
	assign G = (Pi & Gprev) | Gi;

endmodule

module WhiteYellowCircle
	(input logic[1:0]	Pi, Pprev, Gi, Gprev,
	output logic[1:0]	P, G);
	
	assign P = Pi & Pprev;
	assign G = (Pi & Gprev) | Gi;

endmodule

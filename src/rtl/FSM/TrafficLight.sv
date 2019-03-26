module TrafficLight_Mode
	(input logic	clk, NOT_RESET,
					P, R,
	output logic	M);
	
	typedef enum logic[0:0] {S0, S1} stateType;
	stateType currentState, nextState;
	
//	Register logic
	always @(posedge clk, posedge NOT_RESET)
		if (NOT_RESET)	currentState <= S0;
		else if (clk)	currentState <= nextState;
	
//	Next State logic
	always_comb
	
		case (currentState)
			S0:
				if (P)	nextState <= S1;
				else		nextState <= S0;
			S1:
				if (R)	nextState <= S0;
				else		nextState <= S1;
		endcase
	
//	Output logic
	assign M = ((currentState == S1));

endmodule


module TrafficLight_Lights
	(input logic	clk, NOT_RESET,
						Ta, Tb, M,
	output logic[1:0]	La, Lb);
	
	typedef enum logic[1:0] {S0, S1, S2, S3} stateType;
	stateType currentState, nextState;
	
	parameter green =		2'b10;
	parameter yellow =	2'b01;
	parameter red =		2'b00;
	
	always @(posedge clk, posedge NOT_RESET)
		if (NOT_RESET)	currentState <= S0;
		else if (clk)	currentState <= nextState;
		
	always_comb
		
		case (currentState)
			S0:
				if (Ta)		nextState <= S0;
				else			nextState <= S1;
			S1:				nextState <= S2;
			S2:
				if (Tb | M)	nextState <= S2;
				else			nextState <= S3;
			S3:				nextState <= S0;
		endcase

//	Output logic
	always_comb
		case (currentState)
			S0:	{La, Lb} = {green, red};
			S1:	{La, Lb} = {yellow, red};
			S2:	{La, Lb} = {red, green};
			S3:	{La, Lb} = {red, yellow};
		endcase

endmodule


module TrafficLight_Controller
	(input logic	clk, NOT_RESET,
						Ta, Tb, P, R,
	output logic	La, Lb);
	
	logic M;
	
	TrafficLight_Mode modeController(clk, NOT_RESET, P, R, M);
	TrafficLight_Lights lightController(clk, NOT_RESET, Ta, Tb, M, La, Lb);

endmodule

module SnailPatternRecognizer_MooreFSM
	(input logic clk, reset, in,
	output logic out);
	
	typedef enum logic[1:0] {S0, S1, S2} statetype;
	statetype state, nextState;
	
	//	Register logic
	always_ff @(posedge clk, posedge reset)
		if (reset)		state <= S0;
		else if (clk)	state <= nextState;
	
	//	Next state logic
	always_comb
		case (state)
			S0:
				if (in)	nextState = S0;
				else		nextState = S1;
			S1:
				if (in)	nextState = S2;
				else		nextState = S1;
			S2:
				if (in)	nextState = S0;
				else		nextState = S1;
			
			default:		nextState = S0;
		endcase
	
	//	Output logic
	assign out = (state == S2);

endmodule

module SnailPatternRecognizer_MealyFSM
	(input logic clk, reset, in,
	output logic out);
	
	typedef enum logic {S0, S1} typeState;
	typeState currentState, nextState;
	
	//	Register logic
	always_ff @(posedge clk, posedge reset)
		if (reset)		currentState <= S0;
		else if (clk)	currentState <= nextState;
	
	//	Next state logic
	always_comb
		case (currentState)
			S0:
				if (in)		nextState = S0;
				else			nextState = S1;
			S1:
				if (in)		nextState = S0;
				else			nextState = S1;
			
			default:			nextState = S0;
		endcase
	
	assign out = ((currentState == S1) & in);

endmodule

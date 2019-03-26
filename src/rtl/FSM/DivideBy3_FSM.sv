module DivideBy3_FSM
	(input logic NOT_RESET, CLK,
	output logic out);
	
	typedef enum logic[1:0] {S0, S1, S2} statetype;
	statetype state, nextState;
	
	//	Register description
	always @(posedge CLK, posedge NOT_RESET)
	
		if (NOT_RESET)	state <= S0;
		else	state <= nextState;

	//	Next State logic
	always_comb
		case (state)
		
			S0:		nextState <= S1;
			S1:		nextState <= S2;
			S2:		nextState <= S0;
			default:	nextState <= S0;
		
		endcase
		
		//	Output logic
		assign out = (state == S0 | state == S1);

endmodule

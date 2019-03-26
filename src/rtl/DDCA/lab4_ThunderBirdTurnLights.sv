module ThunderBirdTurnLights_lab4
	(input logic	i_clk, i_RESET,
	input logic		i_TurnLeft, i_TurnRight,
	output logic	o_La, o_Lb, o_Lc, o_Ra, o_Rb, o_Rc);
	
	typedef enum logic[6:0]	{s_LightsOff,
							s_La, s_Lab, s_Labc,
							s_Ra, s_Rab, s_Rabc,
							s_EmergencySignal_a, s_EmergencySignal_ab, s_EmergencySignal_abc}	t_Turn_TypeState;
	t_Turn_TypeState	s_currentState, s_nextState;

	/*	Register logic	*/
	always_ff @(posedge i_clk, posedge i_RESET)
	begin
		if (i_RESET)	s_currentState = s_LightsOff;
		else if (i_clk)	s_currentState = s_nextState;
	end


	/*	Next State logic	*/
	always_comb
	begin
		case (s_currentState)
			s_LightsOff:
				if (i_TurnLeft & ~i_TurnRight)		s_nextState = s_La;
				else if (~i_TurnLeft & i_TurnRight)	s_nextState = s_Ra;
				else if (i_TurnLeft & i_TurnRight)	s_nextState = s_EmergencySignal_a;
				else								s_nextState = s_LightsOff;
			
			s_La:									s_nextState = s_Lab;
			s_Lab:									s_nextState = s_Labc;
			s_Labc:									s_nextState = s_LightsOff;
			
			s_Ra:									s_nextState = s_Rab;
			s_Rab:									s_nextState = s_Rabc;
			s_Rabc:									s_nextState = s_LightsOff;
				
			s_EmergencySignal_a:					s_nextState = s_EmergencySignal_ab;
			s_EmergencySignal_ab:					s_nextState = s_EmergencySignal_abc;
			s_EmergencySignal_abc:					s_nextState = s_LightsOff;
		endcase
	end


	/*	Output logic	*/
	assign o_La =	((s_currentState == s_La) || (s_currentState == s_Lab) || (s_currentState == s_Labc) ||
					(s_currentState == s_EmergencySignal_a) || (s_currentState == s_EmergencySignal_ab) || (s_currentState == s_EmergencySignal_abc));
	assign o_Lb =	((s_currentState == s_Lab) || (s_currentState == s_Labc) ||
					(s_currentState == s_EmergencySignal_ab) || (s_currentState == s_EmergencySignal_abc));
	assign o_Lc =	((s_currentState == s_Labc) ||
					(s_currentState == s_EmergencySignal_abc));

	assign o_Ra =	((s_currentState == s_Ra) || (s_currentState == s_Rab) || (s_currentState == s_Rabc) ||
					(s_currentState == s_EmergencySignal_a) || (s_currentState == s_EmergencySignal_ab) || (s_currentState == s_EmergencySignal_abc));
	assign o_Rb =	((s_currentState == s_Rab) || (s_currentState == s_Rabc) ||
					(s_currentState == s_EmergencySignal_ab) || (s_currentState == s_EmergencySignal_abc));
	assign o_Rc =	((s_currentState == s_Rabc) ||
					(s_currentState == s_EmergencySignal_abc));

endmodule

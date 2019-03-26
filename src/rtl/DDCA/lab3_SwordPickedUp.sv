module SwordPickedUp_lab3
	(input logic	i_clk, i_RESET,
	input logic		i_Sword,
	output logic	o_V);
	
	typedef enum logic	{s_SwordNotFound, s_SwordFound}	t_SwordPresence;
	t_SwordPresence	s_currentState, s_nextState;
	
	
	/*	Register logic	*/
	always_ff @(posedge i_clk, posedge i_RESET)
	begin
		if (i_RESET)	s_currentState = s_SwordNotFound;
		else if (i_clk)	s_currentState = s_nextState;
	end
	
	/*	Next state logic	*/
	always_comb
	begin
		case (s_currentState)
			s_SwordNotFound:
				if (i_Sword)	s_nextState = s_SwordFound;
				else			s_nextState = s_SwordNotFound;
			s_SwordFound:
				if (~i_RESET)	s_nextState = s_SwordFound;
				else			s_nextState = s_SwordNotFound;
		endcase
	end
	
	/*	Output logic	*/
	assign o_V = (s_currentState == s_SwordFound);
	
endmodule


module TheAdventureGame_lab3
	(input logic	i_clk, i_RESET,
	input logic		i_N, i_S, i_W, i_E,
	output logic	o_SW,
	output logic	o_WIN, o_DEAD,
	output logic	o_CaveOfCacophony, o_TwistyTunnel, o_RapidRiver,
					o_SecretSwordStash,
					o_DragonsDen, o_VictoryVault, o_GrievousGraveyard);
	
	logic	s_V;
	
	
	Rooms_lab3 Rooms
		(i_clk, i_RESET,
		i_N, i_S, i_W, i_E,
		s_V,
		o_SW,
		o_WIN, o_DEAD,
		o_CaveOfCacophony, o_TwistyTunnel, o_RapidRiver,
		o_SecretSwordStash,
		o_DragonsDen, o_VictoryVault, o_GrievousGraveyard);
	
	SwordPickedUp_lab3 SwordPresence
		(i_clk, i_RESET,
		o_SW,
		s_V);

endmodule

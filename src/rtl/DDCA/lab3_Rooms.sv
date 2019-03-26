module Rooms_lab3
	(input logic	i_clk, i_RESET,
	input logic		i_N, i_S, i_W, i_E,
	input logic		i_V,
	output logic	o_SW,
	output logic	o_WIN, o_DEAD,
	output logic	o_CaveOfCacophony, o_TwistyTunnel, o_RapidRiver,
					o_SecretSwordStash,
					o_DragonsDen, o_VictoryVault, o_GrievousGraveyard);

	typedef enum logic[6:0]	{s_CaveOfCacophony, s_TwistyTunnel, s_RapidRiver,
							s_SecretSwordStash,
							s_DragonsDen, s_VictoryVault, s_GrievousGraveyard}	t_RoomState;
	
	t_RoomState			s_currentState, s_nextState;
	
	
	//	Register logic
	always_ff @(posedge i_clk, posedge i_RESET)
	begin
		if (i_RESET)	s_currentState <= s_CaveOfCacophony;
		else if (i_clk)	s_currentState <= s_nextState;
	end
	
	/*	Next state logic	*/
	always_comb
	begin
		case (s_currentState)
			s_CaveOfCacophony:
				if (i_E)			s_nextState = s_TwistyTunnel;
				else				s_nextState = s_CaveOfCacophony;
			s_TwistyTunnel:
				if (i_W)			s_nextState = s_CaveOfCacophony;
				else if (i_S)		s_nextState = s_RapidRiver;
				else				s_nextState = s_TwistyTunnel;
			s_RapidRiver:
				if (i_W)			s_nextState = s_SecretSwordStash;
				else if (i_N)		s_nextState = s_TwistyTunnel;
				else if (i_E)		s_nextState = s_DragonsDen;
				else				s_nextState = s_RapidRiver;
			s_SecretSwordStash:
				if (i_E)			s_nextState = s_RapidRiver;
				else				s_nextState = s_SecretSwordStash;
			s_DragonsDen:
				if (i_V)			s_nextState = s_VictoryVault;
				else				s_nextState = s_GrievousGraveyard;
				
			s_VictoryVault:
				if (~i_RESET)		s_nextState = s_VictoryVault;
				else				s_nextState = s_CaveOfCacophony;
			s_GrievousGraveyard:
				if (~i_RESET)		s_nextState = s_GrievousGraveyard;
				else				s_nextState = s_CaveOfCacophony;
			
			default:				s_nextState = s_CaveOfCacophony;
		endcase
	end
	
	/*	Output logic	*/
	assign o_CaveOfCacophony = (s_currentState == s_CaveOfCacophony);
	assign o_TwistyTunnel = (s_currentState == s_TwistyTunnel);
	assign o_RapidRiver = (s_currentState == s_RapidRiver);
	assign o_DragonsDen = (s_currentState == s_DragonsDen);
	
	assign o_SecretSwordStash = (s_currentState == s_SecretSwordStash);
	
	assign o_VictoryVault = (s_currentState == s_VictoryVault);
	assign o_GrievousGraveyard = (s_currentState == s_GrievousGraveyard);
	
	
	assign o_SW = (s_currentState == s_SecretSwordStash);
	
	assign o_WIN = (s_currentState == s_VictoryVault);
	assign o_DEAD = (s_currentState == s_GrievousGraveyard);
	
endmodule

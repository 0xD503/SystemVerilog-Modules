module TheAdventureGame_lab3_tb();
	logic[31:0]	v_i, v_j;
	
	logic		l_clk, l_RESET;
	logic		l_N, l_S, l_W, l_E;
	logic		l_SW;
	logic		l_WIN, l_DEAD;
	logic		l_CaveOfCacophony, l_TwistyTunnel, l_RapidRiver,
				l_SecretSwordStash,
				l_DragonsDen, l_VictoryVault, l_GrievousGraveyard;
	
	logic		l_V;
/*
	logic[31:0]	v_VectorNum, v_ErrorsNum;
	logic		c_Underscore;
	logic[3:0]	f_VectorFile[10000:0];
*/

	TheAdventureGame_lab3 DUT
		(l_clk, l_RESET,
		l_N, l_S, l_W, l_E,
		l_SW,
		l_WIN, l_DEAD,
		l_CaveOfCacophony, l_TwistyTunnel, l_RapidRiver,
		l_SecretSwordStash,
		l_DragonsDen, l_VictoryVault, l_GrievousGraveyard);


	/*	Initial system state	*/
	initial
	begin
		
		l_clk = 1'b0;	l_RESET = 1'b0;
		l_N = 1'b0; l_S = 1'b0; l_W = 1'b0; l_E = 1'b0;
		l_SW = 1'b0;
	end
	
	/*	System Clock	*/
	always
	begin
		#5000;	l_clk = !l_clk;
	end
	
	
	event ResetTrigger_Event;
		event	ResetTriggerDone_Event;
		initial
		forever
		begin
			@(ResetTrigger_Event);
			@(negedge l_clk);
			l_RESET = 1'b1;
			for (v_i = 0; v_i < 2; v_i++)
			begin
				@(negedge l_clk);
			end
			l_RESET = 1'b0;
			l_N = 1'b0; l_S = 1'b0; l_W = 1'b0; l_E = 1'b0;
			l_SW = 1'b0;
			->	ResetTriggerDone_Event;
		end

	event FinishTestbench_Event;
	initial
	begin
		@(FinishTestbench_Event);
		#4000;	$finish;
	end

	event Testbench_Event;
		event TestbenchDone_Event;
		initial
		forever
		begin
			@(Testbench_Event);
			#523;
			l_E = 1'b1;
			@(negedge l_clk);
			l_N = 1'b1;
			@(negedge l_clk);
			l_N = 1'b0;	l_S = 1'b1;
			@(negedge l_clk);
			l_W = 1'b1;
			@(negedge l_clk);
			l_W = 1'b1;	l_S = 1'b0;
			@(negedge l_clk);
			l_W = 1'b1;	l_E = 1'b1;
			@(negedge l_clk);
			l_W = 1'b0;	l_E = 1'b1;	l_S = 1'b1;
			@(negedge l_clk);
			l_W = 1'b0;	l_E = 1'b1;	l_S = 1'b0;
			@(negedge l_clk);
			@(negedge l_clk);
			@(negedge l_clk);
			@(negedge l_clk);
			@(negedge l_clk);
			@(negedge l_clk);
			->	TestbenchDone_Event;
			->	FinishTestbench_Event;
		end

		
	event SystemInitialization_Event;
		event SystemInitializationDone_Event;
		initial
		begin
			@(ResetTriggerDone_Event);
			@(negedge l_clk);
			v_i = 0;	v_j = 0;
			l_N = 1'b0; l_S = 1'b0; l_W = 1'b0; l_E = 1'b0;
			l_SW = 1'b0;
			@(negedge l_clk);
			#1;	->	Testbench_Event;
		end


	initial
	begin
		#17433;	->	ResetTrigger_Event;
	end
	
endmodule

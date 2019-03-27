module ThunderBirdTurnLights_lab4_tb();
	logic[31:0]	v_i, v_j;
	
	logic		l_clk, l_RESET;
	logic		l_TurnLeft, l_TurnRight;
	logic		l_La, l_Lb, l_Lc, l_Ra, l_Rb, l_Rc;
	
	ThunderBirdTurnLights_lab4 DUT
		(l_clk, l_RESET,
		l_TurnLeft, l_TurnRight,
		l_La, l_Lb, l_Lc, l_Ra, l_Rb, l_Rc);

	
	
	/*	Initial system state	*/
	initial
	begin
		l_clk = 1'b0;	l_RESET = 1'b0;
		l_TurnLeft = 1'b0;	l_TurnRight = 1'b0;
		l_La = 1'b0;	l_Lb = 1'b0;	l_Lc = 1'b0;	l_Ra = 1'b0;	l_Rb = 1'b0;	l_Rc = 1'b0;
	end
	
	/*	System Clock	*/
	always
	begin
		#5000;	l_clk = !l_clk;
	end
	
	event ResetTrigger_Event;
		event ResetTriggerDone_Event;
		initial
		forever
		begin
			@(ResetTrigger_Event);
			@(negedge l_clk);
			l_RESET = 1'b1;
			for (v_i = 0; v_i < 2; v_i++)	@(negedge l_clk);
			l_RESET = 1'b0;
			l_TurnLeft = 1'b0;	l_TurnRight = 1'b0;
			l_La = 1'b0;	l_Lb = 1'b0;	l_Lc = 1'b0;	l_Ra = 1'b0;	l_Rb = 1'b0;	l_Rc = 1'b0;

			->	ResetTriggerDone_Event;
		end

	event FinishTestbench_Event;
		event FinishTestbenchDone_Event;
		initial
		begin
			@(FinishTestbench_Event);
			#4001;	$finish;

			->	FinishTestbenchDone_Event;
		end
	
	event Testbench_Event;
		event TestbenchDone_Event;
		initial
		forever
		begin
			@(Testbench_Event);
			@(negedge l_clk);
			l_TurnLeft = 1'b1;
			@(negedge l_clk);
			l_TurnRight = 1'b1;
			@(negedge l_clk);
			l_TurnRight = 1'b0;
			@(negedge l_clk);
			@(negedge l_clk);
			l_TurnLeft = 1'b0;
			@(negedge l_clk);
			l_TurnLeft = 1'b1;
			l_TurnRight = 1'b1;
			@(negedge l_clk);
			@(negedge l_clk);
			@(negedge l_clk);
			@(negedge l_clk);
			l_TurnLeft = 1'b0;
			@(negedge l_clk);
			@(negedge l_clk);
			@(negedge l_clk);
			l_TurnRight = 1'b0;
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
			l_TurnLeft = 1'b0;	l_TurnRight = 1'b0;
			l_La = 1'b0;	l_Lb = 1'b0;	l_Lc = 1'b0;	l_Ra = 1'b0;	l_Rb = 1'b0;	l_Rc = 1'b0;
		
			->	SystemInitializationDone_Event;
			->	Testbench_Event;
		end

	initial
	begin
		#17002;	->	ResetTrigger_Event;
	end

endmodule

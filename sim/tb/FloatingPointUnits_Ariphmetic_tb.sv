module FloatingPoindAdder_tb();
	logic		l_clk = 0, l_NOT_RESET = 1;
	logic[31:0]	l_A, l_B, l_S;
	
	logic[31:0]	i, j;
	
	
	FloatingPoint_Adder_SinglePrecision DUT(l_A, l_B, l_S);
	
	always
	begin
		#5000;	l_clk = !l_clk;
	end
	
	initial
	begin
		l_clk = 1'b0;	l_NOT_RESET = 1'b1;
		l_A = 32'b0;	l_B = 32'b0;
	end
	
	event Reset_Trigger;
		event Reset_DoneTrigger;
		initial
		forever
		begin
			@(Reset_Trigger);
			@(negedge l_clk);
			l_NOT_RESET = 1'b0;
			@(negedge l_clk);
			@(negedge l_clk);
			l_NOT_RESET = 1'b1;
			l_A = 32'b0; l_B = 32'b0;
			i = 0; j = 0;
			->	Reset_DoneTrigger;
		end
	
	
	event FinishTest_Trigger;
	initial
	begin
		@(FinishTest_Trigger);
		$finish;
	end
		
	event TestInit_Trigger;
	initial
	forever
	begin
		@(Reset_DoneTrigger);
		@(negedge l_clk);
		l_A = 32'h43A09877;
		l_B = 32'h43001234;
		for (i = 0; i < 77; i++)
		begin
			for (j = 0; j < 3; j++)	@(negedge l_clk);
			#1;	l_A += 31'b1; l_B += 31'd999999;
		end
		->	FinishTest_Trigger;
	end
	
	initial
	begin
		#2777;	->	Reset_Trigger;
	end

endmodule


module FloatingPoindMultiplier_tb();
	logic		l_clk = 0, l_NOT_RESET = 1;
	logic[31:0]	l_A, l_B, l_S;
	
	logic[31:0]	i, j;
	
	
	FloatingPoint_Multiplier_SinglePrecision DUT(l_A, l_B, l_S);
	
	always
	begin
		#5000;	l_clk = !l_clk;
	end
	
	initial
	begin
		l_clk = 1'b0;	l_NOT_RESET = 1'b1;
		l_A = 32'b0;	l_B = 32'b0;
	end
	
	event Reset_Trigger;
		event Reset_DoneTrigger;
		initial
		forever
		begin
			@(Reset_Trigger);
			@(negedge l_clk);
			l_NOT_RESET = 1'b0;
			@(negedge l_clk);
			@(negedge l_clk);
			l_NOT_RESET = 1'b1;
			l_A = 32'b0; l_B = 32'b0;
			i = 0; j = 0;
			->	Reset_DoneTrigger;
		end
	
	
	event FinishTest_Trigger;
	initial
	begin
		@(FinishTest_Trigger);
		$finish;
	end
		
	event TestInit_Trigger;
	initial
	forever
	begin
		@(Reset_DoneTrigger);
		@(negedge l_clk);
		l_A = 32'h43A09877;
		l_B = 32'h43001234;
		for (i = 0; i < 77; i++)
		begin
			for (j = 0; j < 3; j++)	@(negedge l_clk);
			#1;	l_A += 31'b1; l_B += 31'd999999;
		end
		->	FinishTest_Trigger;
	end
	
	initial
	begin
		#2777;	->	Reset_Trigger;
	end

endmodule

module ZeroSequenceCounter_tb();
	logic 		l_clk, l_NOT_RESET, l_ENABLE;
	logic[3:0]	l_out;
	logic[3:0]	expectedOutput;
	logic[31:0]	vectorNum, errorsNum;
	logic[3:0]	vectorFile[10000:0];
	
	ZeroSequenceCounter DUT(l_clk, l_NOT_RESET, l_ENABLE, l_out);
	
	
	initial
	begin
		l_clk = 1'b0;
		l_NOT_RESET = 1'b0;
		l_out = 4'bx;
		vectorNum = 0;	errorsNum = 0;
	end
	
//	Clock process
	always
	begin
		#5000;	l_clk = ~l_clk;
	end

	event Reset_Trigger;
		event Reset_DoneTrigger;
		initial
		begin
			forever
			begin
				@(Reset_Trigger);
				@(negedge l_clk);
				l_NOT_RESET = 1'b1;
				@(negedge l_clk);
				l_NOT_RESET = 1'b0;
				l_out = 4'b0;
				->	Reset_DoneTrigger;
			end
		end
	
	event SystemInit_Trigger;
		event SystemInitDone_Trigger;
		initial
		begin
			forever
			begin
				@(Reset_DoneTrigger);
				@(negedge l_clk);
				#1;	l_ENABLE = 1'b1;
				@(negedge l_clk);
				@(negedge l_clk);
				@(negedge l_clk);
				@(negedge l_clk);
				#1;	l_ENABLE = 1'b0;
				@(negedge l_clk);
				#1;	l_ENABLE = 1'b1;
				@(negedge l_clk);
				@(negedge l_clk);
				#1;	l_ENABLE = 1'b0;
				@(negedge l_clk);
				->	SystemInitDone_Trigger;
			end
		end
	
	initial
	begin
		#3456;	->	Reset_Trigger;
		#700000;	$finish;
	end
	
endmodule
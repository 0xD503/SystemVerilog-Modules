module Rotator_tb();
	logic		l_clk = 0, l_NOT_RESET = 1;
	logic[3:0]	l_in, l_rightRotated, l_leftRotated;
	logic[1:0]	l_shamt;
	
	logic[31:0]	i, j;
	
	Rotator_4 DUT(l_in, l_shamt, l_rightRotated, l_leftRotated);
	
	always
	begin
		#5000;	l_clk = !l_clk;
	end
	
	initial
	begin
		l_clk = 1'b0;	l_NOT_RESET = 1'b1;
		l_shamt = 2'b00;
		l_leftRotated = l_in;	l_rightRotated = l_in;
	end
	
	event Reset_Trigger;
		event Reset_DoneTrigger;
		initial
		forever						//	????????????
		begin
			@(Reset_Trigger);
			@(negedge l_clk);
			l_NOT_RESET = 1'b0;
			@(negedge l_clk);
			@(negedge l_clk);
			l_NOT_RESET = 1'b1;
			l_shamt = 2'b00;
			l_in = 4'b0000;
			l_rightRotated = l_in;
			l_leftRotated = l_in;
			->	Reset_DoneTrigger;
		end
	
	event SystemInit_Trigger;
		event SystemInitDone_Trigger;
		initial
		begin
			forever
			begin
				@(Reset_DoneTrigger);
				@(negedge l_clk);
				l_in = 4'b0111;
				l_shamt = 2'b00;
				for (i = 0; i < 5; i++)		
				begin
					for(j = 0; j< 5; j++)	@(negedge l_clk);
					#2;	l_shamt += 2'd1;
				end								// end for loop
				->	SystemInitDone_Trigger;
			end
		end
	
	initial
	begin
		#3452;		->	Reset_Trigger;
		#700000;	$finish;
	end

endmodule

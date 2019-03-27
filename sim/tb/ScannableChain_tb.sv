module ScannableChain_tb ();
	logic		l_clk, l_RESET;
	logic		l_TST;
	logic		l_TDI, l_TDO;
	logic[3:0]	l_Data_in, l_Data_out;
	
	logic[31:0]	i, j;


	ScannableChain_4_bit DUT	(l_clk, l_RESET,
								l_TST,
								l_TDI,
								l_Data_in,
								l_TDO,
								l_Data_out);

	event Reset_Trigger;
		event Reset_DoneTrigger;
			initial
			forever
			begin
				@(Reset_Trigger);
				@(negedge l_clk);
				@(negedge l_clk);
				l_RESET = 1'b1;
				@(negedge l_clk);
				l_RESET = 1'b0;
				l_TST = 1'b0;
				l_TDI = 1'b0;
				l_Data_in = 1'h0;
				->	Reset_DoneTrigger;
			end
	
	initial
	begin
		l_clk = 1'b0;	l_RESET = 1'b1;
		i = 32'b0;	j = 32'b0;
		#2456;	->	Reset_Trigger;
	end
	
	always
	begin
		#5;	l_clk = !l_clk;
	end
	
	initial
	begin
		#7698;	l_Data_in = 4'h2;
		#500;	l_TDI = 1'b1;
		#500;	l_TST = 1'b1;
		#3000;	$finish;
	end

endmodule

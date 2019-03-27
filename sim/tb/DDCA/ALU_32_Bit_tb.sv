module ALU_tb();
	logic[31:0]	v_i, v_j;
	
	logic		l_clk, l_RESET;
	
	logic[31:0]			l_A, l_B, l_Result;
	logic[1:0]			l_ALUControl;
	logic[3:0]			l_ALUFlags;
	
	

	logic[31:0]	v_VectorNum, v_ErrorsNum;
	logic		c_Underscore;
	logic[3:0]	f_VectorFile[10000:0];


	ALU_32_Bit DUT
		(l_A, l_B,
		l_ALUControl,
		l_Result,
		l_ALUFlags);

	
	/*	Initial system state	*/
	initial
	begin
		v_i = 0;	v_j = 0;
		l_clk = 1'b0;	l_RESET = 1'b0;
		l_A = 32'b0;	l_B = 32'b0;
		l_ALUControl = 2'b0;
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
			l_A = 32'b0; l_B = 32'b0;
			l_ALUControl = 2'b0;
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
			l_A = 32'h00001000;	l_B = 32'h10100010;
			l_ALUControl = 2'b00;
			for (v_i = 0; v_i < 2; v_i++)
			begin
				@(negedge l_clk);
			end
			@(negedge l_clk);
			l_A = 32'hFFFFFFFF;	l_B = 32'hFFFFFFFF;
			l_ALUControl = 2'b01;
			for (v_i = 0; v_i < 2; v_i++)
			begin
				@(negedge l_clk);
			end
			@(negedge l_clk);
			l_A = 32'h00100110;	l_B = 32'h000FFFF0;
			l_ALUControl = 2'b10;
			for (v_i = 0; v_i < 2; v_i++)
			begin
				@(negedge l_clk);
			end
			@(negedge l_clk);
			l_A = 32'h00040100;	l_B = 32'h020FFF00;
			l_ALUControl = 2'b11;
			for (v_i = 0; v_i < 2; v_i++)
			begin
				@(negedge l_clk);
			end
			@(negedge l_clk);
			l_A = 32'hFFFFFFFF;	l_B = 32'hFF000000;
			l_ALUControl = 2'b00;
			for (v_i = 0; v_i < 2; v_i++)
			begin
				@(negedge l_clk);
			end
			#1;	->	Testbench_Event;
		end


	initial
	begin
		#17433;	->	ResetTrigger_Event;
	end


endmodule

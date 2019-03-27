module ALU_32_Bit_WithFlags_tb();
	logic		clk, NOT_RESET;
	logic[31:0]	A, B, Y;
	logic[2:0]	F;
	logic		OVERFLOW, ZERO;
	logic[31:0]	expectedOutput;
	logic[31:0]	vectorsNum, errorsNum;
	
	ALU_32_Bit_WithFlags DUT(A, B, F, Y, OVERFLOW, ZERO);
	
	initial
	begin
		clk = 0;
		NOT_RESET = 1;
		A = 32'bz; B = 32'bz;	F = 3'bz;
		Y = 32'bx;	OVERFLOW = 1'bx; ZERO = 1'bx;
		expectedOutput = 0;
		vectorsNum = 0; errorsNum = 0;
	end
	
	always
	begin
		#5000;	clk = !clk;
	end
	
	
	event Reset_Trigger;
		event Reset_DoneTrigger;
		initial
		begin
			forever
			begin
				@(Reset_Trigger);
				@(negedge clk);
				NOT_RESET = 0;
				@(negedge clk);
				NOT_RESET = 1;
				A = 0; B = 0; F = 3'd0;
				-> Reset_DoneTrigger;
			end
		end
	
	event ChangeMode_Trigger;
		initial
		begin
			@(ChangeMode_Trigger);
			forever
			begin
				@(negedge clk);
				@(negedge clk);
				F = F + 3'd1;
			end
		end
	
	event TerminateSimulation_Trigger;
		initial
		begin
			@(TerminateSimulation_Trigger);
			#102	$finish;
		end
	
	event SystemInit_Trigger;
		event SystemInitDone_Trigger;
		initial
		begin
			forever
			begin
				@(Reset_DoneTrigger);
				@(negedge clk);
				-> ChangeMode_Trigger;
				//-> IncrementA_Case;
				//-> IncrementA_Case;
				-> SystemInitDone_Trigger;
			end
		end
		
	
	event IncrementA_Case;
	initial
	begin
		@(SystemInitDone_Trigger);
		forever
		begin
			@(negedge clk);
			@(negedge clk);
			A = A + 32'd1;
			@(negedge clk);
			A = A + 32'd5;
		end
	end
	
	initial
	begin:	IncrementB_Case
		@(SystemInitDone_Trigger);
		fork
			repeat (32)
			begin
				@(negedge clk);
				B = B + 1'd1;
			end
		join
	end
	
	initial
	begin:	ChangeMode_Case
		@(ChangeMode_Trigger);
		fork
			repeat(16)
			begin
				@(negedge clk);
				F = F + 1'd1;
			end
		join
		//-> TerminateSimulation_Trigger;
	end
	
	
	initial
	begin
		//-> IncrementA;
		//B = 0;
		//F = 3'd2;
		//#120000 $finish;
		->	Reset_Trigger;
		#1200000;	-> TerminateSimulation_Trigger;
	end
	
endmodule

/*
module ALU_tb_SV();
	logic		clk, NOT_RESET;
	logic[31:0]	A, B, Y;
	logic[2:0]	F;
	logic		OVERFLOW, ZERO;
	logic[31:0]	expectedOutput;
	logic		underscore0, underscore1, underscore2, underscore3, underscore4;
	logic[3:0]	vectorFile[10000:0];
	logic[31:0]	vectorNum, errorsNum;
	
	ALU_SV_improved UUT(A, B, F, Y, OVERFLOW, ZERO);

	always
	begin
		clk = 1'b0;	#5000;
		clk = 1'b1;	#5000;
	end
	
	initial
	begin
		$readmemb("G:\\Steven\\My_Folder\\My\\Electro\\FPGA\\Quartus_18\\DDCA_HDL\\vectorFile_ALU.txt", vectorFile);
		vectorNum = 0;
		errorsNum = 0;
		
		NOT_RESET = 1'b0; #12000;	NOT_RESET = 1'b1;
	end
	
	always @(posedge(clk))
	begin
		#1000;	{A, underscore0, B, underscore1, F, underscore2, underscore3, expectedOutput} = vectorFile[vectorNum];
	end
	
	always @(negedge(clk))
		if (NOT_RESET === 1'b1)
		begin
			if (Y !== expectedOutput)
			begin
				$display("Fail: vector %d", vectorNum);
				$display("Output: %h (expected = %h)", Y, expectedOutput);
				errorsNum = errorsNum + 1;
			end
			vectorNum = vectorNum + 1;
			if (vectorFile[vectorNum] === 4'bx)
			begin
				$display("Simulation was completed. %d vectors tested, %d fails occured.", vectorNum, errorsNum);
				$display("Good luck! And get fun, guy!!!");
				$display("Good luck! And get fun, guy!!!");
				$display("Good luck! And get fun, guy!!!");
				
				$finish;
			end
		end

endmodule


module ALU_SV_tb();
	logic		clk, NOT_RESET;
	logic[31:0]	A, B, Y;
	logic[2:0]	F;
	logic		OVERFLOW, ZERO;
	logic[31:0]	expectedOutput;
	logic[31:0]	vectorNum, errorsNum;
	logic[3:0]	vectorFile[10000:0];
	logic[31:0]	underscore0, underscore1, underscore2;
	
	ALU_SV_improved UUT(A, B, F, Y, OVERFLOW, ZERO);
	
	always
		begin
			clk = 0;	#5000;
			clk = 1;	#5000;
		end
	
	initial
		begin
			$readmemb("G:\\Steven\\My_Folder\\My\\Electro\\FPGA\\Quartus_18\\DDCA_HDL\\vectorFile_ALU.txt", vectorFile);
			vectorNum = 0;
			errorsNum = 0;
			
			NOT_RESET = 0; #120000;	NOT_RESET = 1;
		end
	
	always	@(posedge clk)
		begin
			#1000;	{A, underscore0, B, underscore1, F, underscore2, expectedOutput} = vectorFile[vectorNum];
		end
	
	always	@(negedge clk)
		if (NOT_RESET)
		begin
			if (Y !== expectedOutput)
			begin
				$display("Fail: vector %d", vectorNum);
				$display("Output: %h (expected = %h)", Y, expectedOutput);
				errorsNum = errorsNum + 1;
			end
			vectorNum = vectorNum + 1;
			if (vectorFile[vectorNum] === 4'bx)
			begin
				$display("Simulation was completed. %d vectors tested, %d fails occured.", vectorNum, errorsNum);
				$display("Good luck! And get fun, guy!!!");
				
				$finish;
			end
		end

endmodule
*/
/*
module ALU_SV_tb();
	logic		clk, NOT_RESET;
	logic[31:0]	A, B, Y;
	logic[2:0]	F;
	logic		OVERFLOW, ZERO;
	logic[31:0]	expectedOutput;
	logic[31:0]	vectorsNum, errorsNum;
	
	ALU_SV_improved DUT(A, B, F, Y, OVERFLOW, ZERO);
	
	initial
	begin
		clk = 0;
		NOT_RESET = 1;
		A = 32'bz;	B = 32'bz;	F = 3'bz;
		Y = 32'bx;	OVERFLOW = 1'bx;	ZERO = 1'bx;
		expectedOutput = 0;
		vectorsNum = 0;	errorsNum = 0;
	end
	
	always
	begin
		#5000;	clk = !clk;
	end
	
	initial
	begin
		$dumpfile ("ALU.vcd");
		$dumpvars;
	end
	
	initial
	begin
		$display("\t\ttime,\tclk,\tNOT_RESET");
		$monitor("%d,\t%b,\t\t\t\t\t%b", $time, clk, NOT_RESET);
	end
	
	
	//initial
		//#100000	$finish;
	
	event terminteSimulation;
		initial
		begin
			@(terminteSimulation);
			#5;	$finish;
		end
	
	event Reset_Trigger;
		event Reset_DoneTrigger;
		initial
		begin
			forever
			begin
				@(Reset_Trigger);
				@(negedge clk);
				NOT_RESET = 0;
				@(negedge clk);
				NOT_RESET = 1;
				-> Reset_DoneTrigger;
			end
		end
	
	initial
	begin: Reset_Case0
		#4200;	-> Reset_Trigger;
		@(Reset_DoneTrigger);
		fork
			repeat (10)
			begin
				@(negedge clk);
				NOT_RESET = $random;
			end
		join
		#5 -> terminteSimulation;
	end

endmodule
*/

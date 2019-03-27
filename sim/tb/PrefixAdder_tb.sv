module PrefixAdder_tb();
	logic		clk, NOT_RESET;
	logic[15:0]	A, B, S, expectedOutput;
	logic		Cin, Cout;
	logic[31:0]	vectorNum, errorsNum;
	logic		underscore;
	logic[3:0]	vectorFile[1000:0];
	
	PrefixAdder UUT(A, B, Cin, S, Cout);
	
	always
	begin
		clk = 0; #5;	clk = 1; #5;
	end
	
	initial
	begin
		$readmemb("G:\Steven\My_Folder\My\Electro\FPGA\Quartus_18\DDCA_HDL\vectorFile_ex5_4.txt", vectorFile);
		vectorNum = 0;
		errorsNum = 0;
		
		NOT_RESET = 0;	# 17; NOT_RESET = 1;
	end
	
	
	always @(posedge clk)
	begin
		#1;	{A, underscore, B, underscore, Cin, underscore, underscore, expectedOutput} = vectorFile[vectorNum];
	end
	
	always @(negedge clk)
		if (NOT_RESET)
		begin
			if (S !== expectedOutput)
			begin
				$display("Fail: %d vectorNum;", vectorNum);
				$display("Output: %h (expected = %h)", S, expectedOutput);
				errorsNum = errorsNum + 1;
			end
			vectorNum = vectorNum + 1;
			if (vectorFile[vectorNum] === 4'bx)
			begin
				$display("Simulation was completed.");
				$display("%d fails.", errorsNum);

				$finish;
			end
		end

endmodule

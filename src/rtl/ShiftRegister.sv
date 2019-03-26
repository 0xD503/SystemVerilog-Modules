module ShiftRegister
	#(parameter N = 8)
	(input logic		clk,
						reset, Load, Enable,
						Sin,
	input logic[N-1:0]	Din,
	output logic		Sout,
	output logic[N-1:0]	Dout);
	
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)		Dout <= 0;
		else if (Enable)
		begin
			if (clk)
			begin
				if (Load)	Dout <= Din;
				else		Dout <= {Dout[N-1-1:0], Sin};
			end
		end
	end

	assign Sout = Dout[N-1];
		
endmodule

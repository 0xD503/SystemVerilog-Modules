module Counter
	#(parameter N = 8)
	(input logic			clk, NOT_RESET, EN,
	output logic[(N - 1):0]	out);
	
	always_ff	@(posedge clk, negedge NOT_RESET)
		if (~NOT_RESET)
		begin
			out <= 0;
		end
		else if (EN)
		begin
			out <= out + 1'd1;
		end
endmodule

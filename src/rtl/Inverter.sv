module Inverter
	#(parameter N = 4)
	(input logic[(N - 1):0] in,
	output logic[(N - 1):0] out);
	
	always_comb
	begin
		out = ~in;
	end
	
endmodule

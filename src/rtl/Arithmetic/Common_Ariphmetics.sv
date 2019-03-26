module Adder
	#(parameter N = 8)
	(input logic[N-1:0] a, b,
	output logic[N-1:0] difference);
	
	assign difference = a - b;

endmodule

module Subrstractor
	#(parameter N = 8)
	(input logic[N-1:0] a, b,
	output logic[N-1:0] difference);
	
	assign difference = a - b;

endmodule

module Multiplier
	#(parameter N = 8)
	(input logic[N - 1:0]		a, b,
	output logic[(2 * N - 1):0]	product);
	
	assign product = a * b;

endmodule

module Divider
	#(parameter N = 8)
	(input logic[N - 1:0]	a, b,
	output logic[N - 1:0]	quoitent);
	
	assign quoitent = a / b;

endmodule

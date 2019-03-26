module Comparator
	#(parameter N = 8)
	(input logic[N-1:0]	a, b,
	output logic			equal, nequal, lt, lte, gt, gte);
	
	assign equal = (a == b);
	assign nequal = (a != b);
	assign lt = (a < b);
	assign lte = (a <= b);
	assign gt = (a > b);
	assign gte = (a >= b);

endmodule

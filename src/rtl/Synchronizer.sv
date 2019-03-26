module Synchronizer
	(input logic clk,
	input logic[3:0] d,
	output logic[3:0] q);
	
	logic[3:0] n1;

	always_ff @(posedge clk)
	begin
	
		n1 <= d;
		q <= n1;
	
	end

endmodule

module NotSynchronizer_code1
	(input logic	clk,
					a, b, c,
	output logic y);
	
	logic x;
	
	always_ff @(posedge clk)	begin
		if (clk)
			x = a & b;
			y <= c | x;
		
	end

endmodule

module NotSynchronizer_code2
	(input logic	clk,
						a, b, c,
	output logic y);
	
	logic x;
	
	always_ff @(posedge clk)	begin
		y <= c | x;
		x = a & b;
	end

endmodule

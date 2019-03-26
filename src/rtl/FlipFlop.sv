module FlipFlop
	(input logic clk, en, sclr, aclr,
	input logic[3:0] d,
	output logic[3:0] q);
	
	always_ff @(posedge clk, posedge aclr)
	begin
	
		if (aclr)	q <= 4'b0;
		else
			if (en)
				if (sclr)	q <= 4'b0;
				else			q <= d;

	end
	
endmodule


module Two_FlipFlops
	(input logic	clk,
	input logic		d0, d1,
	output logic	q0, q1);
	
	always_ff @(posedge clk)
	begin
		q1 <= d1;
		q0 <= d0;
	end
	
endmodule

module D_Latch
	(input logic en,
	input logic[3:0] d,
	output logic[3:0] q);
	
	always_latch
	begin
		if (en)	q <= d;
	end

endmodule

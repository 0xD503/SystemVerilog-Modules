module Tristate
	(input logic[3:0] inputTristate,
	input logic enable,
	output tri[3:0] outputTristate);
		
	assign outputTristate = enable ? inputTristate : 4'bz;

endmodule

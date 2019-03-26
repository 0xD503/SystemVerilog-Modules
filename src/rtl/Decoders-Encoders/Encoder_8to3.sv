module Encoder_8to3
	(input logic[7:0]	in,
	output logic[2:0]	out,
	output logic		NONE);
	
	logic	seventh, sixth, fiveth, fourth, third, second, first, zeroth;
	
	assign seventh = in[7];
	assign sixth = ~in[7] & in[6];
	assign fiveth = ~in[7] & ~in[6] & in[5];
	assign fourth = ~in[7] & ~in[6] & ~in[5] & in[4];
	assign third = ~in[7] & ~in[6] & ~in[5] & ~in[4] & in[3];
	assign second = ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & in[2];
	assign first = ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & ~in[2] & in[1];
	assign zeroth = ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & ~in[2] & ~in[1] & in[0];
	
	assign out[0] = seventh | fiveth | third | first;
	assign out[1] = seventh | sixth | third | second;
	assign out[2] = seventh | sixth | fiveth | fourth;
	
	assign NONE = ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & ~in[2] & ~in[1] & ~in[0];

endmodule

module Rotator_4
	#(parameter N = 8)
	(input logic[(N - 1):0]	in,
	input logic[1:0]		shamt,
	output logic[(N - 1):0]	rightRotated, leftRotated);
	
//	rightRotated out logic
	always_comb
	begin
		case (shamt)
			2'b00:		rightRotated = in;
			2'b01:		rightRotated = {in[0], in[(N - 1): 1]};
			2'b10:		rightRotated = {in[1:0], in[(N - 1): 2]};
			2'b11:		rightRotated = {in[2:0], in[(N - 1): 3]};
			default:	rightRotated = in;
		endcase
	end
	
//	leftRotated out logic
	always_comb
	begin
		case (shamt)
			2'b00:		leftRotated = in;
			2'b01:		leftRotated = {in[(N - 2): 0], in[(N - 1)]};
			2'b10:		leftRotated = {in[(N - 3): 0], in[(N - 1):(N - 2)]};
			2'b11:		leftRotated = {in[(N - 4): 0], in[(N - 1):(N - 3)]};
			default:	leftRotated = in;
		endcase
	end

endmodule

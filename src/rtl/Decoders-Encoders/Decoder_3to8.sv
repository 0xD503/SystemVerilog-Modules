module Decoder_3to8
	(input logic[2:0] in,
	output logic[7:0] out);
	
	always_comb
	begin
	
		case(in)
			3'o0:		out = 8'b00000001;
			3'o1:		out = 8'b00000010;
			3'o2:		out = 8'b00000100;
			3'o3:		out = 8'b00001000;
			3'o4:		out = 8'b00010000;
			3'o5:		out = 8'b00100000;
			3'o6:		out = 8'b01000000;
			3'o7:		out = 8'b10000000;
			default:	out = 8'bxxxxxxxx;
		endcase
	
	end

endmodule

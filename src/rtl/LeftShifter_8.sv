module LeftShifter_8
	(input logic[7:0]		i_in,
	input logic[2:0]		i_shamt,
	output logic[7:0]		o_out);
	
	
	always_comb
	begin
		case (i_shamt)
			3'b000:		o_out = i_in;
			3'b001:		o_out = {i_in[6:0], 1'b0};
			3'b010:		o_out = {i_in[5:0], 2'b0};
			3'b011:		o_out = {i_in[4:0], 3'b0};
			3'b100:		o_out = {i_in[3:0], 4'b0};
			3'b101:		o_out = {i_in[2:0], 5'b0};
			3'b110:		o_out = {i_in[1:0], 6'b0};
			3'b111:		o_out = {i_in[0], 7'b0};
			default:	o_out = i_in;
		endcase
	end

endmodule

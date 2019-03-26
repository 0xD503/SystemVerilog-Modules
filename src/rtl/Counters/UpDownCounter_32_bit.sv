module UpDownCounter_32_bit
	(input logic 		i_clk, i_RESET,
	input logic			UP,
	output logic[31:0]	o_Out);


	always @(posedge i_clk, posedge i_RESET)
	begin
		if (i_RESET)	o_Out <= 32'b0;
		else if (UP)	o_Out <= o_Out + 1;
		else			o_Out <= o_Out - 1;
	end

endmodule

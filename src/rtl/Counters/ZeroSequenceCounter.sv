module ZeroSequenceCounter
	(input logic		i_clk, i_NOT_RESET, i_ENABLE,
	output logic[3:0]	o_out);
	
	logic[3:0]			c_MAX = 9;
	logic[3:0]			v_MAX = 0;
	logic[3:0]			v_countCurrent = 0;

	
	always	@(posedge i_clk, posedge i_NOT_RESET)
	begin
		if (i_NOT_RESET)
		begin
			v_MAX <= 0;
			v_countCurrent <= 0;
		end
		else
		begin
			if (i_ENABLE == 1)
			begin
				v_countCurrent <= v_countCurrent + 4'b1;
				if (v_countCurrent < c_MAX)		
				begin
					if (v_countCurrent > v_MAX)		v_MAX <= v_countCurrent;
				end
				else								v_countCurrent <= 4'b0;
			end
			else								v_countCurrent <= 4'b1;
		end
	end
	
	assign o_out = v_MAX;

endmodule

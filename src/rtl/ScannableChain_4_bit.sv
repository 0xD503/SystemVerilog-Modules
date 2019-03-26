//	JTAG
module ScannableChain_4_bit
	(input logic		i_TCK, i_RESET,
	input logic			i_TST,
	input logic			i_TDI,
	input logic[3:0]	i_in,
	output logic		o_TDO,
	output logic[3:0]	o_out);
	
	logic				zeroth_Sout, first_Sout, second_Sout;//, third_Sout, fourth_Sout, fiveth_Sout, sixth_Sout;
	
	Scannable_FlipFLop zerothRegister(i_TCK, i_RESET, i_TST, i_in[0], i_TDI, o_out[0], zeroth_Sout);
	Scannable_FlipFLop firstRegister(i_TCK, i_RESET, i_TST, i_in[1], zeroth_Sout, o_out[1], first_Sout);
	Scannable_FlipFLop secondRegister(i_TCK, i_RESET, i_TST, i_in[2], first_Sout, o_out[2], second_Sout);
	Scannable_FlipFLop thirdRegister(i_TCK, i_RESET, i_TST, i_in[3], second_Sout, o_out[3], o_TDO);

endmodule


module Scannable_FlipFLop
	(input logic	i_TCK, i_RESET,
	input logic		i_TST,
	input logic		i_Data, i_TDI,
	output logic	o_Q, o_TDO);

	always @(posedge i_TCK, posedge i_RESET)
	begin
		if (i_RESET)
		begin
			o_Q <= 1'b0;
			o_TDO <= 1'b0;
		end
		else
			if (i_TST)
			begin
				o_Q <= i_TDI;
				o_TDO <= i_TDI;
			end
			else
			begin
				o_Q <= i_Data;
				o_TDO <= i_Data;
			end
	end

endmodule

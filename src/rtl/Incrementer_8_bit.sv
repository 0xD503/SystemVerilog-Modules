module Incrementer_8_bit
	(input logic		i_clk, i_RESET,
	input logic[7:0]	i_in,
	output logic[7:0]	o_out);
	
	logic[7:0]			s_IncrementedValue;
	logic				zerothCarry, firstCarry, secondCarry, thirdCarry, fourthCarry, fivethCarry, sixthCarry, seventhCarry;

	Half_Adder zerothBit(i_in[0], 1'b1, s_IncrementedValue[0], zerothCarry);
	Half_Adder firstBit(i_in[1], zerothCarry, s_IncrementedValue[1], firstCarry);
	Half_Adder secondBit(i_in[2], firstCarry, s_IncrementedValue[2], secondCarry);
	Half_Adder thirdBit(i_in[3], secondCarry, s_IncrementedValue[3], thirdCarry);
	Half_Adder fourthBit(i_in[4], thirdCarry, s_IncrementedValue[4], fourthCarry);
	Half_Adder fivethBit(i_in[5], fourthCarry, s_IncrementedValue[5], fivethCarry);
	Half_Adder sixthBit(i_in[6], fivethCarry, s_IncrementedValue[6], sixthCarry);
	Half_Adder seventhBit(i_in[7], sixthCarry, s_IncrementedValue[7], seventhCarry);
	
	always @(posedge i_clk, posedge i_RESET)
	begin
		if (i_RESET)	o_out <= 8'b0;
		else			o_out <= s_IncrementedValue;
	end
	
endmodule

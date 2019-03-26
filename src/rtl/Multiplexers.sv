module  Mux2
	#(parameter width = 32)
	(input logic[(width - 1):0] d0, d1,
	input logic sel,
	output logic[(width - 1):0] out);
		
	assign out = sel ? d0 : d1;

endmodule

module Mux4
	(input logic d0, d1, d2, d3,
	input logic[1:0] sel,
	output logic out);
	
	logic lowBit, highBit;
	
	mux2_SV #(1) lowMux(d0, d1, sel[0], lowBit);
	mux2_SV highMux(d2, d3, sel[0], highBit);
	mux2_SV finalMux(lowBit, highBit, sel[1], out);
endmodule

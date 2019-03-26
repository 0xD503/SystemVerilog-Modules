module And_N
	#(parameter width = 8)
	(input logic[(width - 1):0] in,
	output logic out);
	
	genvar i;
	logic[(width - 1):0] transitionalOutput;
	
	generate
		assign transitionalOutput[0] = in[0];
		for (i = 1; i < width; i = i + 1)
		begin: forloop
			assign transitionalOutput[i] = transitionalOutput[i - 1] & in[i];
		end
	endgenerate
	
	assign out = transitionalOutput[width - 1];
endmodule

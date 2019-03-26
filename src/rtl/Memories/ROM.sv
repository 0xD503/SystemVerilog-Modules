module ROM
	(input logic[1:0]	addr,
	output logic[3:0]	data_out);
	
	always_comb
	
		case (addr)
		
			2'b00:	data_out = 3'b011;
			2'b01:	data_out = 3'b110;
			2'b10:	data_out = 3'b100;
			2'b11:	data_out = 3'b010;

			default:	data_out = 3'b000;
		
		endcase

endmodule

module RAM_Array
	#(parameter N = 6, M = 32)
	(input logic				clk,
								//reset,
								WE,
	input logic[(N-1):0]		data_addr,
	input logic[M - 1:0]		data_in,
	output logic[(M - 1):0]		data_out);

	typedef logic [M-1:0]mem[2**N - 1:0];
	mem mem_arr;

	always_ff @(posedge clk)
	begin
		if (WE)		mem_arr[data_addr] <= data_in;
	end


	assign data_out = mem_arr[data_addr];

endmodule

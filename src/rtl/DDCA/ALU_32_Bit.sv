module ALU_32_Bit
	(input  logic [31:0] i_A, i_B,
    input  logic [1:0]  i_ALUControl,
    output logic [31:0] o_Result,
    output logic [3:0]  o_ALUFlags);	/*	Flags: N, Z, C, V	*/

	logic[31:0]			s_Sum, s_Diff, s_And, s_Or;
	logic[32:0]			s_FullSum;


	assign s_Sum = i_A + i_B;
	assign s_FullSum = i_A + i_B;
	assign s_Diff = i_A - i_B;
	assign s_And = i_A & i_B;
	assign s_Or = i_A | i_B;

	/*	Output logic	*/
	always_comb
	begin
		case (i_ALUControl)
			2'd0:
			begin
				o_Result <= s_Sum;
			end
			
			2'd1:
			begin
				o_Result <= s_Diff;
			end
			
			2'd2:
			begin
				o_Result <= s_And;
			end
			
			2'd3:
			begin
				o_Result <= s_Or;
			end
		endcase
	end

	/*	Flags	*/
	always_comb
	begin
		case (i_ALUControl)
			2'd0:
			begin
				o_ALUFlags[3] <= o_Result[31];																	/*	N	*/
				o_ALUFlags[2] <= (s_Sum == 0) ?	1'b1 : 1'b0;													/*	Z	*/
				o_ALUFlags[1] <= s_FullSum[31];																	/*	C	*/
				o_ALUFlags[0] <= (i_A[31] ^ i_B[31] ^ i_ALUControl[0]) & (s_Sum[31] ^ i_A[31]);						/*	V	*/
			end
			
			2'd1:
			begin
				o_ALUFlags[3] <= o_Result[31];																	/*	N	*/
				o_ALUFlags[2] <= (s_Sum == 0) ?	1'b1 : 1'b0;													/*	Z	*/
				o_ALUFlags[1] <= s_FullSum[31];																	/*	C	*/
				o_ALUFlags[0] <= (i_A[31] ^ i_B[31] ^ i_ALUControl[0]) & (s_Sum[31] ^ i_A[31]);						/*	V	*/
			end
			
			2'd2:
			begin
				o_ALUFlags[3] <= o_Result[31];																	/*	N	*/
				o_ALUFlags[2] <= (s_Sum == 0) ?	1'b1 : 1'b0;													/*	Z	*/
				o_ALUFlags[1] <= 1'b0;																			/*	C	*/
				o_ALUFlags[0] <= 1'b0;																			/*	V	*/
			end
			
			2'd3:
			begin
				o_ALUFlags[3] <= o_Result[31];					/*	N	*/
				o_ALUFlags[2] <= (s_Sum == 0) ?	1'b1 : 1'b0;	/*	Z	*/
				o_ALUFlags[1] <= 1'b0;							/*	C	*/
				o_ALUFlags[0] <= 1'b0;							/*	V	*/
			end
		endcase
	end

endmodule

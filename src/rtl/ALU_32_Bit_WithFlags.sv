module ALU_Improved
	#(parameter N = 32)
	(input logic[(N - 1):0]	A, B,
	input logic[2:0]		F,
	output logic[(N - 1):0]	Y,
	//output logic			Cout, 
	output logic			Overflow, Zero);

	logic					Cin;
	logic[(N - 1):0]		B_Out;
	logic					ADD, SUB;
	logic[(N - 1):0]		Sum;
	logic[(N - 1):0]		ZeroExtension_Unit;
	
	
	assign Cin = F[2];
	assign B_Out = (F[2] == 1) ?	~B : B;
	assign ADD = (F[2] == 1) ?	1'b0 : 1'b1;
	
	assign Sum = A + B_Out + Cin;
	
	assign ZeroExtension_Unit[(N - 1):1] = 0;
	assign ZeroExtension_Unit[0] = Sum[N - 1];		//	Set if A < B
	
	//assign Zero = (Sum == 0) ?	1'b1 : 1'b0;
	
	always_comb
		case (F[1:0])
			2'b00:	Y <= A & B_Out;
			2'b01:	Y <= A | B_Out;
			2'b10:	Y <= Sum[(N - 1):0];
			2'b11:	Y <= ZeroExtension_Unit;
			
			//default:	Y <= ;
		endcase
	
	always_comb
		case (ADD)
			0:
				begin
					Overflow <= (A[N - 1] & ~B[N - 1] & ~Sum[N - 1]) | (~A[N - 1] & B[N - 1] & Sum[N - 1]);
					Zero <= (Sum == 0) ?	1'b1 : 1'b0;
				end
			1:	
				begin
					Overflow <= (~A[N - 1] & ~B[N - 1] & Sum[N - 1]) | (A[N - 1] & B[N - 1] & ~Sum[N - 1]);
					Zero <= (Sum == 0) ?	1'b1 : 1'b0;
				end
		endcase

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Homework 6 Question 1
//////////////////////////////////////////////////////////////////////////////////
module Question1(input zero, one, rst, clk, //zero/one are input values
					  output reg unlock, //unlock is one when the sequence is correct
					  output reg [2:0] state); //the state the FSM is currently in
	parameter s1 = 3'b000; parameter s2 = 3'b001; parameter s3 = 3'b010;
	parameter s4 = 3'b011; parameter s5 = 3'b100;

	always@ (posedge clk or posedge rst) begin
		if (rst) begin
			state <= s1;
			unlock <= 0;
		end
		else begin
			case (state)
				s1: begin if (zero) state <= s2;
							 else state <= s1;
					 end
				s2: begin if (zero) state <= s2;
							 else if (one) state <= s3;
							 else state <= s1;
					 end
				s3: begin if (zero) state <= s4;
							 else state <= s1;
					 end
				s4: begin if (zero) state <= s5;
							 else state <= s1;
					 end
				s5: begin if (zero) state <= s2;
							 else if (one) unlock <= 1; //unlock = 1 if the sequence was 01001
							 else state <= s1;
					 end
				default: state <= s1;
			endcase
		end
	end
endmodule

module tb_question1;
	reg clk, rst, zero, one;
	wire unlock;
	wire [2:0] state;
	
	Question1 test1 (.zero(zero), .one(one), .clk(clk), .rst(rst), .unlock(unlock), .state(state));
	
	initial clk = 0;
	always #5 clk = ~clk;
	
	initial begin
	rst = 1; zero = 0; one = 0;
	#7 rst = 0; zero = 1;
	#3 ;
	#10;
	#10;
	#10 zero = 0; one = 1;
	#10 zero = 1; one = 0;
	#10;
	#10 zero = 0; one = 1;
	#10 zero = 1; one = 0;
	#10 zero = 0; one = 1;
	#10 ;
	#10 ;
	end
endmodule

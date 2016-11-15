`timescale 1ns / 1ps

module Datapath(
		input clk,
		input [1:0] SelA,
		input SelB,
		input WrAcc,
		input Op,
		input [10:0] operand,
		input [15:0] in_memory_data,
		output reg [15:0] out_memory_data
    );
	 
	 reg [15:0] ACC;
	 reg [15:0] extended_operand;
	 reg [15:0] out_SelA;
	 reg [15:0] out_SelB;
	 reg [15:0] Op_result;
	 integer i;
	 
	 //signal extension
	 always@*
	 begin
		extended_operand[10:0] <= operand;
		for(i = 0; i<5; i=i+1)
			extended_operand[i+11] <= operand[10];
	 end
	 
	 //Multiplexor A
	 always@*
	 begin
		case(SelA)
			0: out_SelA <= in_memory_data;
			1: out_SelA <= extended_operand;
			2: out_SelA <= Op_result;
		endcase
	 end
	 
	 //Multiplexor B
	 always@*
	 begin
		case(SelB)
			0: out_SelB <= in_memory_data;
			1: out_SelB <= extended_operand;
		endcase
	 end
	 
	 //Sumador/Restador
	 always@*
	 begin
		case(Op)
			0: Op_result <= ACC + out_SelB;
			1: Op_result <= ACC - out_SelB;
		endcase
	 end
	 
	 //sincronismo del ACC
	 always@(posedge clk)
	 begin
		if(WrAcc) ACC <= out_SelA;
	 end
	 
	 
	 //outs
	 always@*
	 begin
		out_memory_data <= ACC;
	 end


endmodule

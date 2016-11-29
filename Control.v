`timescale 1ns / 1ps

module Control(
		input clk,
		input rst,
		input [15:0] instruction,
		output reg [10:0] program_counter,
		output wire [1:0] SelA,
		output wire SelB,
		output wire WrAcc,
		output wire Op,
		output wire WrRam,
		output wire RdRam
    );
	 
	 wire WrPC;
	 reg [10:0] PC_In;
	
	always@(negedge clk)
	begin
		if(rst==0) program_counter = 0;
		else
			if(WrPC==1) program_counter = PC_In;
	end
	
	InstructionDecoder decoder(.opcode(instruction[15:11]), .WrPC(WrPC), .SelA(SelA), .SelB(SelB), .WrAcc(WrAcc),
										.Op(Op), .WrRam(WrRam), .RdRam(RdRam));
	
	

	always@*
	begin
		PC_In = program_counter + 1;
	end
	
	
	
	
	
endmodule

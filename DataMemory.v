`timescale 1ns / 1ps

module DataMemory(input clk, input Rd, input Wr, input [10:0] address, input [15:0]In_Data, output reg [15:0] Out_Data);

	reg [15:0] memory [0:2047];
	
	always@(negedge clk)
	begin
		if(Rd) Out_Data = memory[address];
		else
			if(Wr) memory[address] = In_Data;
	end


endmodule

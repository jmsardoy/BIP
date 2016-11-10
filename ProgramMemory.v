`timescale 1ns / 1ps

module ProgramMemory(input clk, input rst,input [11:0] address, output reg [15:0] data);
	
	reg [15:0] memory [0:2047];
	
	always@(posedge clk)
	begin
		if(rst == 0)
		begin
			memory[0] = 7;
			memory[1] = 456;
			memory[2000] = 123;
			data = 0;
		end
	end
	
	always@(posedge clk)
	begin
		data = memory[address];
	end
	

endmodule

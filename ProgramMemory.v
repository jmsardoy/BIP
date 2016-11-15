`timescale 1ns / 1ps

module ProgramMemory(input clk, input rst,input [10:0] address, output reg [15:0] data);
	
	reg [15:0] memory [0:2047];
	
	always@(negedge clk)
	begin
		if(rst == 0)
		begin
			memory[0] = 'b0001100000000100; //LDI 4
			memory[1] = 'b0000100000000001; //STO 1
			memory[2] = 'b0001100000000010; //LDI 2
			memory[3] = 'b0001000000000001; //LD 1
			memory[4] = 'b0010000000000001; //ADD 1
			memory[5] = 0; //HALT
			data = 0;
		end
	end
	
	always@(negedge clk)
	begin
		data = memory[address];
	end
	

endmodule

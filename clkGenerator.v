`timescale 1ns / 1ps

module clkGenerator(input clk, output reg program_clk, output reg data_clk);
	
   reg flag = 0;
	always@(posedge clk)
	begin
		program_clk = flag;
		flag = !flag;
	end
	
	always@(negedge clk)
	begin
		data_clk = !flag;
	end

endmodule

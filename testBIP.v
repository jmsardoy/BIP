`timescale 1ns / 1ps

module testBIP;

	// Inputs
	reg clk;
	reg rst;
	wire tx_out;

	BIP uut (
		.clk(clk), 
		.rst(rst),
		.tx_out(tx_out)
	);

	initial begin

		clk = 0;
		rst = 0;

		#4;
		rst = 1;
       

	end
	
	always
	begin
		#1; clk = 1;
		#1; clk = 0;
	end
      
endmodule


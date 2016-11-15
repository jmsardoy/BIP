`timescale 1ns / 1ps

module testBIP;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	BIP uut (
		.clk(clk), 
		.rst(rst)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		// Wait 100 ns for global reset to finish
		#4;
		rst = 1;
        
		// Add stimulus here

	end
	
	always
	begin
		#1; clk = 1;
		#1; clk = 0;
	end
      
endmodule


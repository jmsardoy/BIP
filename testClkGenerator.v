`timescale 1ns / 1ps


module testClkGenerator;

	// Inputs
	reg clk;

	// Outputs
	wire program_clk;
	wire data_clk;

	// Instantiate the Unit Under Test (UUT)
	clkGenerator uut (
		.clk(clk), 
		.program_clk(program_clk), 
		.data_clk(data_clk)
	);

	initial begin
		// Initialize Inputs
		clk = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always
	begin
		#1; clk = 0;
		#1; clk = 1;
	end
      
endmodule


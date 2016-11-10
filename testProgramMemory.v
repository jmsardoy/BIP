`timescale 1ns / 1ps

module testProgramMemory;

	// Inputs
	reg clk;
	reg rst;
	reg [11:0] address;
	

	// Outputs
	wire [15:0] data;

	// Instantiate the Unit Under Test (UUT)
	ProgramMemory uut (
		.clk(clk),
		.rst(rst),
		.address(address), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		address = 0;
		
		rst = 0;
		// Wait 100 ns for global reset to finish
		#10;
		rst = 1;
		
		#50;
		address = 1;
		#50;
		address = 2000;
        
		// Add stimulus here

	end
	
	always
	begin
		#1; clk = 0;
		#1; clk = 1;
	end
      
endmodule


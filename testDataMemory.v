`timescale 1ns / 1ps

module testDataMemory;

	// Inputs
	reg clk;
	reg rst;
	reg Rd;
	reg Wr;
	reg [10:0] address;
	reg [15:0] In_Data;

	// Outputs
	wire [15:0] Out_Data;

	// Instantiate the Unit Under Test (UUT)
	DataMemory uut (
		.clk(clk), 
		.rst(rst), 
		.Rd(Rd), 
		.Wr(Wr), 
		.address(address), 
		.In_Data(In_Data), 
		.Out_Data(Out_Data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		Rd = 0;
		Wr = 0;
		address = 0;
		In_Data = 0;

		// Wait 100 ns for global reset to finish
		#100;
		address = 53;
		In_Data = 123;
		Wr = 1;
		#2;
		Wr = 0;
		#2;
		Rd = 1;
		#2;
		Rd = 0;
		
		
        
		// Add stimulus here

	end
	
   always
	begin
		#1;clk = 1;
		#1;clk = 0;
	end
endmodule


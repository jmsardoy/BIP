`timescale 1ns / 1ps


module testControl;

	// Inputs
	reg clk;
	reg [15:0] instruction;
	reg rst;

	// Outputs
	wire [10:0] program_counter;
	wire [10:0] data_address;
	wire [1:0] SelA;
	wire SelB;
	wire WrAcc;
	wire Op;
	wire WrRam;
	wire RdRam;

	// Instantiate the Unit Under Test (UUT)
	Control uut (
		.clk(clk),
		.rst(rst),
		.instruction(instruction), 
		.program_counter(program_counter), 
		.data_address(data_address), 
		.SelA(SelA), 
		.SelB(SelB), 
		.WrAcc(WrAcc), 
		.Op(Op), 
		.WrRam(WrRam), 
		.RdRam(RdRam)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		instruction = 0;
		rst = 0;
		#10;
		rst = 1;
		// Wait 100 ns for global reset to finish
		#2;
		instruction = 'b0000100000000111;
		#2;
		instruction = 'b0001000000000000;
		#2;
		instruction = 'b0001100000000000;
		#2;
		instruction = 'b0000000000000000;
		#2;
		instruction = 'b0011100000000000;
        
		// Add stimulus here

	end
	
	always
	begin
		#1; clk = 0;
		#1; clk = 1;
	end
      
endmodule


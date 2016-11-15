`timescale 1ns / 1ps

module testDatapath;

	// Inputs
	reg clk;
	reg [1:0] SelA;
	reg SelB;
	reg WrAcc;
	reg Op;
	reg [10:0] operand;
	reg [15:0] in_memory_data;

	// Outputs
	wire [15:0] out_memory_data;
	wire [10:0] data_address;

	// Instantiate the Unit Under Test (UUT)
	Datapath uut (
		.clk(clk), 
		.SelA(SelA), 
		.SelB(SelB), 
		.WrAcc(WrAcc), 
		.Op(Op), 
		.operand(operand), 
		.in_memory_data(in_memory_data), 
		.out_memory_data(out_memory_data),
		.data_address(data_address)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		SelA = 0;
		SelB = 0;
		WrAcc = 0;
		Op = 0;
		operand = 0;
		in_memory_data = 0;

		// store value 5
		#3;
		in_memory_data = 5;
		SelA = 0;
		SelB = 0;
		WrAcc = 1;
		Op = 0;
		//substract immediate 6
		#2
		operand = -6;
		SelA = 2;
		SelB = 1;
		WrAcc = 1;
		Op = 1;
		//halt
		#2
		SelA = 0;
		SelB = 0;
		WrAcc = 0;
		Op = 0;
        
		// Add stimulus here

	end
	
	always
	begin
		#1; clk = 1;
		#1; clk = 0;
	end
      
endmodule


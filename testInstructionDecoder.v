`timescale 1ns / 1ps

module testInstructionDecoder;

	// Inputs
	reg [4:0] opcode;

	// Outputs
	wire WrPC;
	wire [1:0] SelA;
	wire SelB;
	wire WrAcc;
	wire Op;
	wire WrRam;
	wire RdRam;

	// Instantiate the Unit Under Test (UUT)
	InstructionDecoder uut (
		.opcode(opcode), 
		.WrPC(WrPC), 
		.SelA(SelA), 
		.SelB(SelB), 
		.WrAcc(WrAcc), 
		.Op(Op), 
		.WrRam(WrRam), 
		.RdRam(RdRam)
	);

	initial begin
		// Initialize Inputs
		opcode = 'b00000;

		// Wait 100 ns for global reset to finish
		#10;
      opcode = 'b00001;
		#10;
		opcode = 'b00010;
		#10;
		opcode = 'b00011;
		#10;
		opcode = 'b00100;
		#10;
		opcode = 'b00101;
		#10;
		opcode = 'b00110;
		#10;
		opcode = 'b00111;
		// Add stimulus here

	end
      
endmodule


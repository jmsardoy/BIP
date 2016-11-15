`timescale 1ns / 1ps

module BIP(
		input clk,
		input rst
    );
	
	wire [10:0] address_program_memory;
	wire [15:0] data_program_memory;
	wire Rd;
	wire Wr;
	wire [10:0] data_address;
	wire [15:0] In_Data_memory;
	wire [15:0] Out_Data_memory;
	wire [1:0] SelA;
	wire SelB;
	wire WrAcc;
	wire Op;
	
	wire program_clk;
	wire data_clk;
	
	clkGenerator clock(.clk(clk),.program_clk(program_clk),.data_clk(data_clk));
	
	ProgramMemory program_memory(.clk(program_clk),.rst(rst),.address(address_program_memory),.data(data_program_memory));
	
	Control control(.clk(program_clk),.rst(rst),.instruction(data_program_memory),.program_counter(address_program_memory),
						.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.WrRam(Wr),.RdRam(Rd));
	
	Datapath datapath(.clk(program_clk),.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.operand(data_program_memory[10:0]),
							.in_memory_data(Out_Data_memory),.out_memory_data(In_Data_memory));
	
	DataMemory data_memory(.clk(data_clk),.rst(rst),.Rd(Rd),.Wr(Wr),.address(data_program_memory[10:0]),.In_Data(In_Data_memory),
								.Out_Data(Out_Data_memory));
	
	/*
	ProgramMemory program_memory(.clk(clk),.rst(rst),.address(address_program_memory),.data(data_program_memory));
	
	Control control(.clk(clk),.rst(rst),.instruction(data_program_memory),.program_counter(address_program_memory),
						.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.WrRam(Wr),.RdRam(Rd));
	
	Datapath datapath(.clk(clk),.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.operand(data_program_memory[10:0]),
							.in_memory_data(Out_Data_memory),.out_memory_data(In_Data_memory));
	
	DataMemory data_memory(.clk(clk),.rst(rst),.Rd(Rd),.Wr(Wr),.address(data_program_memory[10:0]),.In_Data(In_Data_memory),
								.Out_Data(Out_Data_memory));*/
							
	
endmodule

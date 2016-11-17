`timescale 1ns / 1ps

module BIP(
		input clk,
		input rst,
		output wire tx_out
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
	wire out_baudrate;
	wire program_clk;
	wire data_clk;
	wire tx_done;
	
	reg [7:0]tx_data_in = 0;
	reg tx_start = 0;
	
	
	clkGenerator clock(.clk(clk),.program_clk(program_clk),.data_clk(data_clk));
	
	ProgramMemory program_memory(.clk(program_clk),.rst(rst),.address(address_program_memory),.data(data_program_memory));
	
	Control control(.clk(program_clk),.rst(rst),.instruction(data_program_memory),.program_counter(address_program_memory),
						.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.WrRam(Wr),.RdRam(Rd));
	
	Datapath datapath(.clk(program_clk),.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.operand(data_program_memory[10:0]),
							.in_memory_data(Out_Data_memory),.out_memory_data(In_Data_memory));
	
	DataMemory data_memory(.clk(data_clk),.rst(rst),.Rd(Rd),.Wr(Wr),.address(data_program_memory[10:0]),.In_Data(In_Data_memory),
								.Out_Data(Out_Data_memory));
	
	BaudRateGenerator baudrate(.clk(clk), .out(out_baudrate));
	
	TX tx(.clk(clk), .baud_rate(out_baudrate), .d_in(tx_data_in), .tx_start(tx_start), .tx(tx_out), .tx_done(tx_done));
	
	
	reg [2:0]state = 0;
	
	integer i = 0;
	reg [7:0] reg1 = 0;
	reg [7:0] reg2 = 0;
	
	
	

	always@(posedge clk)
	begin
		if(rst == 0) state = 0;
		if(data_program_memory[15:10] == 0)
			begin
				if(tx_start == 0)
				begin
					case(state)
						0:
							begin
								reg1 = In_Data_memory[15:8];
								reg2 = In_Data_memory[7:0];
								state = 1;
							end
						1: if(tx_done == 1) state = 2;
						2: 
							begin
								tx_data_in = reg1;
								tx_start = 1;
								state = 3;
							end
						3: state = 4;
						4: if(tx_done == 1) state = 5;
						5: 
							begin
								tx_data_in = reg2;
								tx_start=1;
								state = 6;
								end
						6:;
					endcase
				end
				else begin
					tx_start = 0;
					end
			end
	end
	
	
endmodule

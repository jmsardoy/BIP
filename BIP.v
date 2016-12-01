`timescale 1ns / 1ps

module BIP(
		input clk,
		input rst,
		output wire	 tx_out,
		output reg led_rst
    );
	
	wire [10:0] address_program_memory;
	wire [15:0] data_program_memory;
	wire Rd;
	wire Wr;
	wire [15:0] In_Data_memory;
	wire [15:0] Out_Data_memory;
	wire [1:0] SelA;
	wire SelB;
	wire WrAcc;
	wire Op;
	wire out_baudrate;
	wire tx_done;
	
	reg [7:0]tx_data_in = 0;
	reg tx_start = 0;
	
	
	ProgramMemory program_memory(.clk(clk),.rst(rst),.address(address_program_memory),.data(data_program_memory));
	
	Control control(.clk(clk),.rst(rst),.instruction(data_program_memory),.program_counter(address_program_memory),
						.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.WrRam(Wr),.RdRam(Rd));
	
	Datapath datapath(.clk(clk),.SelA(SelA),.SelB(SelB),.WrAcc(WrAcc),.Op(Op),.operand(data_program_memory[10:0]),
							.in_memory_data(Out_Data_memory),.out_memory_data(In_Data_memory));
	
	DataMemory data_memory(.clk(clk),.Rd(Rd),.Wr(Wr),.address(data_program_memory[10:0]),.In_Data(In_Data_memory),
								.Out_Data(Out_Data_memory));
	
	BaudRateGenerator baudrate(.clk(clk), .out(out_baudrate));
	
	TX tx(.clk(clk),/*.rst(rst),*/ .baud_rate(out_baudrate), .d_in(tx_data_in), .tx_start(tx_start), .tx(tx_out),
			.tx_done(tx_done));
	
	
	reg [3:0] state = 0;
	reg [3:0] next_state = 0;
	

	
	always@(posedge clk)
	begin
		if(rst == 0) state = 0;
		else state = next_state;
	end
	
	
	//logica de cambio de estado
	//inputs: data_program_memory, tx_start, tx_done
	//outputs: next_state
	always@*
	begin
		case(state)
		0: begin
				if(data_program_memory[15:10] != 0) next_state = 1;
				else next_state = 0;
			end
		1: begin
				if(data_program_memory[15:10] == 0) next_state = 2;
				else next_state = 1;
			end
		2: begin
				next_state = 3;
			end
		3: begin
				if(tx_start == 1) next_state = 4;
				else next_state = 3;
			end
		4: begin
				if(tx_start == 0) next_state = 5;
				else next_state = 4;
			end
		5: begin
				if(tx_done)	next_state = 6;
				else next_state = 5;
			end
		6: begin
				if(tx_start == 1) next_state = 7;
				else next_state = 6;
			end
		7: begin
				if(tx_start == 0) next_state = 8;
				else next_state = 7;
			end
		8: begin
				if(tx_done == 1) next_state = 0;
				else next_state = 8;
			end
		default: next_state = 0;
		endcase
	end
	
	
	//logica de salida
	//ouputs: tx_start, tx_data_in
	always@*
	begin
		case(state)
		0: begin
				tx_start = 0;
				tx_data_in = 0;
			end
		1: begin
				tx_start = 0;
				tx_data_in = 0;
			end
		2: begin				
				if(tx_done == 1)
				begin
					tx_data_in[7:0] = In_Data_memory[15:8];
					
					tx_start = 0;
				end
				
				//agrego else por warning de latches
				else begin
					tx_start = 0;
					tx_data_in = 0;
				end
			end
		3: begin
				tx_start = 1;
				
				tx_data_in[7:0] = In_Data_memory[15:8];

			end
		4: begin
				if(tx_done == 0)
				begin
					tx_start = 0;
					
					tx_data_in[7:0] = In_Data_memory[15:8];
				
				end
				//agrego else por warning de latches
				else begin
					tx_start = 1;
					tx_data_in[7:0] = In_Data_memory[15:8];
				end
			end
		5: begin
				if(tx_done == 1)
				begin
					tx_data_in = In_Data_memory[7:0];
					
					tx_start = 0;
				end
				
				//agrego else por warning de latches
				else begin
					tx_start = 0;
					tx_data_in[7:0] = In_Data_memory[15:8];
				end
			end
		6: begin
				tx_start = 1;
				
				tx_data_in = In_Data_memory[7:0];
			end
		7: begin
				if(tx_done == 0)
				begin
					tx_start = 0;
					
					tx_data_in = In_Data_memory[7:0];
				end
				
				//agrego else por warning de latches
				else begin
					tx_start = 1;
					tx_data_in = In_Data_memory[7:0];					
				end
			end
		8: begin
				if(tx_done == 1)
				begin
					tx_start = 0;
					tx_data_in = 0;
				end
				
				else
				begin
					tx_start = 0;
					tx_data_in = In_Data_memory[7:0];
				end
			end
		default: begin
			tx_start = 0;
			tx_data_in = 0;
			end
		endcase
	end
	
	always@*
	begin
		led_rst = rst;
	end
	
	/*reg [2:0]state = 0;
	reg [7:0] reg1 = 0;
	reg [7:0] reg2 = 0;
	
	always@(posedge clk)
	begin
		if(rst == 0) state = 0;
		else
		begin
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
	end
	*/
	
	
endmodule

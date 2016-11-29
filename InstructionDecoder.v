`timescale 1ns / 1ps

module InstructionDecoder(
		input [4:0] opcode,
		output reg WrPC,
		output reg [1:0] SelA,
		output reg SelB,
		output reg WrAcc,
		output reg Op,
		output reg WrRam,
		output reg RdRam
		);
		
		always@*
		begin
			case(opcode)
				0: //halt
				begin
					WrPC <= 0;
					SelA <= 0;
					SelB <= 0;
					WrAcc <= 0;
					Op <= 0;
					WrRam <= 0;
					RdRam <= 0;
				end
				1: //Store Variable
				begin
					WrPC <= 1;
					SelA <= 0;
					SelB <= 0;
					WrAcc <= 0;
					Op <= 0;
					WrRam <= 1;
					RdRam <= 0;
					
				end
				2: //Load Variable
				begin
					WrPC <= 1;
					SelA <= 0;
					SelB <= 0;
					WrAcc <= 1;
					Op <= 0;
					WrRam <= 0;
					RdRam <= 1;
				end
				3: //Load Immediate
				begin
					WrPC <= 1;
					SelA <= 1;
					SelB <= 0;
					WrAcc <= 1;
					Op <= 0;
					WrRam <= 0;
					RdRam <= 0;
				end
				4: //Add Variable
				begin
					WrPC <= 1;
					SelA <= 2;
					SelB <= 0;
					WrAcc <= 1;
					Op <= 0;
					WrRam <= 0;
					RdRam <= 1;
				end
				5: //Add Immediate
				begin
					WrPC <= 1;
					SelA <= 2;
					SelB <= 1;
					WrAcc <= 1;
					Op <= 0;
					WrRam <= 0;
					RdRam <= 0;
				end
				6: //Substract Variable
				begin
					WrPC <= 1;
					SelA <= 2;
					SelB <= 0;
					WrAcc <= 1;
					Op <= 1;
					WrRam <= 0;
					RdRam <= 1;
				end
				7: //Substract Immediate
				begin
					WrPC <= 1;
					SelA <= 2;
					SelB <= 1;
					WrAcc <= 1;
					Op <= 1;
					WrRam <= 0;
					RdRam <= 0;
				end
				default:
				begin
					WrPC <= 0;
					SelA <= 0;
					SelB <= 0;
					WrAcc <= 0;
					Op <= 0;
					WrRam <= 0;
					RdRam <= 0;
				end
			endcase
		end


endmodule

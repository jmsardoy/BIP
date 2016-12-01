`timescale 1ns / 1ps

module TX
	#( parameter stateA = 5'b00001,
		parameter stateB = 5'b00010,
		parameter stateC = 5'b00100,
		parameter stateD = 5'b01000,
		parameter stateE = 5'b10000)
	(input clk,
	//input rst,
    input baud_rate,
    input [7:0]d_in,
    input tx_start,
    output reg tx,
    output reg tx_done);

	reg [4:0] state = stateA;
	reg [4:0] next_state = stateA;
	
	reg tick_enable = 0;
	integer count = 0;
	reg rst_count = 1;
	integer bit_count = 0;
   reg [7:0] d_aux;
	
	
	always@(posedge clk)
	begin
		/*if(rst == 0) state = 0;
		else*/
			state=next_state;
	end

    always@(posedge clk)
    begin
        case(state)
            stateA:
                if(tx_start == 1) next_state = stateB;
                else next_state = stateA;
            stateB:
                if(bit_count == 1) next_state = stateC;
                else next_state = stateB;
            stateC:
                if(bit_count == 9) next_state = stateD;
                else next_state = stateC;
            stateD:
                if(bit_count == 10) next_state = stateE;
                else next_state =  stateD;
            stateE:
                if(tx_done == 1) next_state = stateA;
                else next_state = stateE;
				default: next_state = 0;
        endcase
    end

    always@(posedge clk)
    begin
        case(state)
            stateA:
            begin
                tx = 1;
                tx_done = 1;
                rst_count = 0;
					 tick_enable = 0;
            end
            stateB:
            begin
					tx_done = 0;
					rst_count = 1;
					tick_enable = 1;
					if(count == 16)
					begin
					  tx = 0;
					  d_aux = d_in;
					  bit_count = bit_count + 1;
					  rst_count = 0;
					end
            end
            stateC:
            begin
					rst_count = 1;
					if(count == 16)
					begin
					  tx = d_aux[0];
					  d_aux = d_aux >> 1;
					  bit_count = bit_count + 1;
					  rst_count = 0;
					end
            end
            stateD:
				begin
					rst_count = 1;
					if(count == 16)
					begin
						tx = 1;
						bit_count = bit_count + 1;
						rst_count = 0;
					end
            end
            stateE:
            begin
					if(count == 16)
					begin
						bit_count = 0;
						tx_done = 1;
					end
            end
				default: tx_done = 1;
        endcase
    end
                
                
always@(posedge baud_rate or negedge rst_count)
    begin
		if(rst_count == 0) count = 0;
		else
		begin
			if(tick_enable == 1)count = count + 1;
		end
    end
	
endmodule

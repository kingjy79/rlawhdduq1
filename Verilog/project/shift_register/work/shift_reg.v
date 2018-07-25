module shift_reg
//#(parameter =
(
input i_clk, i_rst_n,
input i_load,
input [4-1:0] i_data,
output reg o_data );

localparam S0=1'b0, S1=1'b1;

reg state;
reg [2-1:0] count;
reg [4-1:0] temp_data;

always @(posedge i_clk, negedge i_rst_n) begin
	if(!i_rst_n) begin
		o_data<=0;
		state<=0;
		temp_data<=0;
		count<=0;
		end
	else begin
		case(state)
			S0:begin
				if(i_load==1) begin
					temp_data<=i_data;
					state<=S1;
					end
				else
					state<=S0;
				end
			S1:begin
				if(count<4) begin
					o_data<=temp_data[count];
					count<=count+1;
					state<=S1;
					end
				else begin
					o_data<=0;
					state<=S0;
					end
				end
			endcase
	
		end
	end
endmodule

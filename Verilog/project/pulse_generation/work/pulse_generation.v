module pulse_generation
//#(parameter)
(
input i_clk, i_rst_n,
output reg o_pulse);

reg [10-1:0] inner_count=0;

always @(posedge i_clk, negedge i_rst_n) begin
	if(!i_rst_n)
		o_pulse<=0;
	else begin
		inner_count<=inner_count+1;
		end
		if(inner_count<219) begin
			o_pulse<=1;
			end
		else if(inner_count>=219 && 
				inner_count<658) begin//inner_count>=219
			o_pulse<=0;
			end
		else begin //inner_count>=658
			inner_count<=0;
		end
	end
endmodule

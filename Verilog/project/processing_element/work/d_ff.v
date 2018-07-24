module d_ff
#(parameter N=1)(
input i_clk, i_rst_n,
input signed [N-1:0] i_data,
output reg signed [N-1:0] o_data);

always @(posedge i_clk, negedge i_rst_n) begin
	if(!i_rst_n) begin
		o_data<=0;
		end
	else begin
		o_data<=i_data;
		end
	end
endmodule

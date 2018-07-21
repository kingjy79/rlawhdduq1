module d_ff
#(parameter N=1)(
input i_clk, i_rstn,i_enable,
input [N-1:0] i_data,
output reg [N-1:0] o_data);

always @(posedge i_clk, negedge i_rst_n) begin
	if(!i_rst_n) begin
		o_data<=0;
		end
	else begin
		if(i_enable==1)
			o_data<=i_data;
		else
		o_data<=o_data;
		end
	end
endmodule
	
	

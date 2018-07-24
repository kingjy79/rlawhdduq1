module d_ff_n_bit
#(parameter N=8)(
input i_clk,
input i_rst_n,
input [N-1:0] i_data,
output reg [N-1:0] o_data);

always @(posedge i_clk, negedge i_rst_n) begin
  	if(!i_rst_n)
    	o_data<=0;
    else
    	o_data<=i_data;
  	end

endmodule

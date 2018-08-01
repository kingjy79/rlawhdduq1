module d_ff
#(parameter D=1)(
input i_clk,
input i_rst_n,
input [D-1:0] i_data,
output reg [D-1:0] o_data);

always @(posedge i_clk, negedge i_rst_n) begin
  	if(!i_rst_n)
    	o_data<=0;
    else
    	o_data<=i_data;
  	end

endmodule

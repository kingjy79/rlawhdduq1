module generate_d_ff
#(parameter N=1,D=3)(
input i_clk, i_rst_n,
input 		[N-1:0] i_data,
output 		[N-1:0] o_data);

wire [N-1:0] temp[0:D];//[0:D] is depth

assign temp[0]=i_data;
genvar i;
	generate for(i=0;i<D;i=i+1)
	begin: gen_d_ff
		d_ff_n_bit #(N) d_ff_n(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_data(temp[i]),
		.o_data(temp[i+1]));
		end
	endgenerate
assign o_data=temp[D];

endmodule

module generate_d_ff
#(parameter D=1,N=3)(
input i_clk, i_rst_n,
input 		[D-1:0] i_data,
output 		[D-1:0] o_data);

wire [D-1:0] temp[0:N];//[0:N] is depth,number

assign temp[0]=i_data;
genvar i;
	generate for(i=0;i<N;i=i+1)
	begin: gen_d_ff
		d_ff #(D) 
			d_ff_n(
				.i_clk(i_clk),
				.i_rst_n(i_rst_n),
				.i_data(temp[i]),
				.o_data(temp[i+1]));
		end
	endgenerate
assign o_data=temp[N];

endmodule

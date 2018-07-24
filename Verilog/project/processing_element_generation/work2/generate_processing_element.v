module generate_processing_element
#(parameter XW=8, WW=8, BW1=16, BW2=19, N=1, D=1)(
input i_clk, i_rst_n,
input signed [XW-1:0] i_x,
input signed [WW-1:0] i_w,
input signed [BW1-1:0] i_psum,
output signed [BW2-1:0] o_psum);

wire signed [BW2-1:0] temp_psum [0:D]; //D is depth.

assign temp_psum[0]=i_psum;
genvar i;
	generate for(i=0;i<D;i=i+1)
	begin: generate_processing_element 
		processing_element
		#(.XW(XW), .WW(WW), .BW1(BW1), .BW2(BW2), .N(N))
			pe0(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_x(i_x),
		.i_w(i_w),
		.i_psum(temp_psum[i]),
		.o_psum(temp_psum[i+1]));
		end
	endgenerate
assign o_psum=temp_psum[D];

endmodule

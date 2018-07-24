module processing_element
#(parameter BW1=1, BW2=1, N=1, XW=1, WW=1)
(
input i_clk, i_rst_n,
input signed [XW-1:0] i_x,
input signed [WW-1:0] i_w,
input signed [BW1-1:0] i_psum,
output signed [BW2-1:0] o_psum);

wire signed [XW+WW-1:0] result_multiply;
wire signed [BW2-1:0] result_adder;


//description top_module
multiply #(.XW(XW), .WW(WW)) mul0(
				.i_x(i_x),
				.i_w(i_w),
				.o_multiply(result_multiply));
adder #(.BW1(BW1), .BW2(BW2)) add0 (
						.i_data(result_multiply),
						.i_psum(i_psum),
						.o_data(result_adder));
d_ff #(.N(N)) dff0 (
					.i_clk(i_clk),
					.i_rst_n(i_rst_n),
					.i_data(result_adder),
					.o_data(o_psum));


endmodule


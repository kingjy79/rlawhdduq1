module convolution_3x3
#(parameter I_BW=19, O_BW=19, X_BW=8, W_BW=8, DFF_BW=19, DFF_TIMES=27)
(
input i_clk, i_rst_n,
input signed [X_BW-1:0] i_x,
input signed [W_BW-1:0] i_w,
input signed [I_BW-1:0] i_psum,
output signed [O_BW-1:0] o_y);

wire signed [O_BW-1:0] r_psum0;
wire signed [O_BW-1:0] r_psum1;
wire signed [O_BW-1:0] r_psum2;
wire signed [O_BW-1:0] r_psum3;
wire signed [O_BW-1:0] r_psum4;
wire signed [DFF_BW-1:0] r_sat0;

processing_element #(.BW1(I_BW), .BW2(O_BW), .XW(X_BW), .WW(W_BW), .N(DFF_BW))
	pe0_0(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(i_psum),
	.o_psum(r_psum0));



processing_element #(.BW1(I_BW), .BW2(O_BW), .XW(X_BW), .WW(W_BW), .N(DFF_BW))
	pe0_1(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum0),
	.o_psum(r_psum1));



processing_element #(.BW1(I_BW), .BW2(O_BW), .XW(X_BW), .WW(W_BW), .N(DFF_BW))
	pe0_2(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum1),
	.o_psum(r_psum2));



processing_element #(.BW1(I_BW), .BW2(O_BW), .XW(X_BW), .WW(W_BW), .N(DFF_BW))
	pe0_3(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum2),
	.o_psum(r_psum3));



processing_element #(.BW1(I_BW), .BW2(O_BW), .XW(X_BW), .WW(W_BW), .N(DFF_BW))
	pe0_4(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum3),
	.o_psum(r_psum4));



saturation #(.N(O_BW), .K(DFF_BW))
	sat0(
	.i_data(r_psum4),
	.o_data(o_y));


endmodule

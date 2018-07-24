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
/* 
I_BW<==>BW1
O_BW<==>BW2
X_BW<==>XW
W_BW<==>WW
N<==>DFF_BW
*/

processing_element #(.BW1(16), .BW2(16), .XW(8), .WW(8), .N(16))
	pe0_0(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(i_psum),
	.o_psum(r_psum0));



processing_element #(.BW1(16), .BW2(17), .XW(8), .WW(8), .N(17))
	pe0_1(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum0),
	.o_psum(r_psum1));



processing_element #(.BW1(17), .BW2(17), .XW(8), .WW(8), .N(17))
	pe0_2(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum1),
	.o_psum(r_psum2));



processing_element #(.BW1(17), .BW2(18), .XW(8), .WW(8), .N(18))
	pe0_3(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum2),
	.o_psum(r_psum3));



processing_element #(.BW1(18), .BW2(19), .XW(8), .WW(8), .N(19))
	pe0_4(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum3),
	.o_psum(r_psum4));



saturation #(.N(19), .K(16))
	sat0(
	.i_data(r_psum4),
	.o_data(o_y));



endmodule


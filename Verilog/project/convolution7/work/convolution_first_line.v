module convolution_first_line
#(parameter I_X=8, I_W=8, I_PSUM=16, O_SAT=16)//D is D_F/F's BW,,We use dff_generation ,not yet
(
input i_clk, i_rst_n,
input signed [I_X-1:0] i_x,
input signed [I_W-1:0] i_w,
input signed [I_PSUM-1:0] i_psum,
output signed [O_SAT-1:0] o_psum);

wire signed [16-1:0] r_psum0;
wire signed [17-1:0] r_psum1;
wire signed [17-1:0] r_psum2;
wire signed [18-1:0] r_psum3;
wire signed [19-1:0] r_psum4;


processing_element #( .I_X(8), .I_W(8), .O_MULTIPLY(16), .I_PSUM(16), .O_ADDER(16), .D(16), .O_PSUM(16) )
	pe0_0(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(i_psum),
	.o_psum(r_psum0));



processing_element #( .I_X(8), .I_W(8), .O_MULTIPLY(16), .I_PSUM(16), .O_ADDER(17), .D(17), .O_PSUM(17) )
	pe0_1(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum0),
	.o_psum(r_psum1));



processing_element #( .I_X(8), .I_W(8), .O_MULTIPLY(16), .I_PSUM(17), .O_ADDER(17), .D(17), .O_PSUM(17) )
	pe0_2(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum1),
	.o_psum(r_psum2));



processing_element #( .I_X(8), .I_W(8), .O_MULTIPLY(16), .I_PSUM(17), .O_ADDER(18), .D(18), .O_PSUM(18) )
	pe0_3(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum2),
	.o_psum(r_psum3));



processing_element #( .I_X(8), .I_W(8), .O_MULTIPLY(16), .I_PSUM(18), .O_ADDER(19), .D(19), .O_PSUM(19) )
	pe0_4(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum3),
	.o_psum(r_psum4));



saturation #(.I(19), .O(O_SAT)) //combination logic.
	sat0(
	.i_data(r_psum4),
	.o_data(o_psum));



endmodule

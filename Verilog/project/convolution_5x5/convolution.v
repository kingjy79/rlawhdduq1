module convolution_first_line
#(parameter I_X=8, I_W=8, I_PSUM=16, O_PSUM=19, O_MULTIPLY=16, O_ADDER=19, D=19, O_SAT=16)//D is D_F/F's BW,,We use dff_generation ,not yet
(
input i_clk, i_rst_n,
input signed [I_X-1:0] i_x,
input signed [I_W-1:0] i_w,
input signed [I_PSUM-1:0] i_psum,
output signed [O_PSUM-1:0] o_psum);

wire signed [16-1:0] r_psum0;
wire signed [16-1:0] r_psum1;
wire signed [17-1:0] r_psum2;
wire signed [17-1:0] r_psum3;
wire signed [18-1:0] r_psum4;


processing_element #( .I_X(I_X), .I_W(I_W), .O_MULTIPLY(O_MULTIPLY), .I_PSUM(I_PSUM), .O_ADDER(O_ADDER), .D(D), .O_PSUM(O_PSUM) )
	pe0_0(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(i_psum),
	.o_psum(r_psum0));



processing_element #( .I_X(I_X), .I_W(I_W), .O_MULTIPLY(O_MULTIPLY), .I_PSUM(I_PSUM), .O_ADDER(O_ADDER), .D(D), .O_PSUM(O_PSUM) )
	pe0_1(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum0),
	.o_psum(r_psum1));



processing_element #( .I_X(I_X), .I_W(I_W), .O_MULTIPLY(O_MULTIPLY), .I_PSUM(I_PSUM), .O_ADDER(O_ADDER), .D(D), .O_PSUM(O_PSUM) )
	pe0_2(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum1),
	.o_psum(r_psum2));



processing_element #( .I_X(I_X), .I_W(I_W), .O_MULTIPLY(O_MULTIPLY), .I_PSUM(I_PSUM), .O_ADDER(O_ADDER), .D(D), .O_PSUM(O_PSUM) )
	pe0_3(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum2),
	.o_psum(r_psum3));



processing_element #( .I_X(I_X), .I_W(I_W), .O_MULTIPLY(O_MULTIPLY), .I_PSUM(I_PSUM), .O_ADDER(O_ADDER), .D(D), .O_PSUM(O_PSUM) )
	pe0_4(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(r_psum3),
	.o_psum(r_psum4));



saturation #(.I(O_PSUM), .O(O_SAT)) //combination logic.
	sat0(
	.i_data(r_psum4),
	.o_data(o_psum));



endmodule

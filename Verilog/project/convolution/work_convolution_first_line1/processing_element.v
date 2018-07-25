module processing_element
#(parameter I_X=8, I_W=8, I_PSUM=16, O_PSUM=19, O_MULTIPLY=16, O_ADDER=19, D=19)
(
input i_clk, i_rst_n,
input signed [I_X-1:0] i_x,
input signed [I_W-1:0] i_w,
input signed [I_PSUM-1:0] i_psum,
output signed [O_PSUM-1:0] o_psum);


wire signed [O_MULTIPLY-1:0] r_multiply;
wire signed [O_ADDER-1:0] r_adder;


//description top_module
multiply #(.I_X0(I_X), .I_X1(I_W), .O_Y0(O_MULTIPLY)) 
	mul0(
		.i_x0(i_x),
		.i_x1(i_w),
		.o_y0(r_multiply));
adder #(.I_X0(I_PSUM), .I_X1(O_MULTIPLY), .O_Y0(O_ADDER)) 
	add0 (
		.i_x0(i_psum),
		.i_x1(r_multiply),
		.o_y0(r_adder));
d_ff #(.D(D)) 
	dff0 (
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_data(r_adder),
		.o_data(o_psum));


endmodule


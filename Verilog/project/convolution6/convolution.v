module convolution
#(parameter I_X=8, I_W=8, I_PSUM=16, O_SAT=16)//not yet
(
input i_clk, i_rst_n,
input signed [I_X-1:0] i_x,
input signed [I_W-1:0] i_w,
input signed [I_PSUM-1:0] i_psum,
output signed [O_SAT-1:0] o_psum);

wire signed [O_SAT-1:0] r_psum0;
wire signed [O_SAT-1:0] r_psum1;
wire signed [O_SAT-1:0] r_psum2;
wire signed [O_SAT-1:0] r_psum3;
wire signed [O_SAT-1:0] r_psum4;
wire signed [O_SAT-1:0] r_psum5;
wire signed [O_SAT-1:0] r_psum6;
wire signed [O_SAT-1:0] r_psum7;

convolution_first_line #(.I_X(I_X), .I_W(I_W), .I_PSUM(I_PSUM), .O_SAT(O_SAT))
	cfl0(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_x(i_x),
		.i_w(i_w),
		.i_psum(i_psum),
		.o_psum(r_psum0) );

generate_d_ff #(.D(O_SAT), .N(27))
	gdf0(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_data(r_psum0),
		.o_data(r_psum1) ); //finish first line.

convolution_first_line #(.I_X(I_X), .I_W(I_W), .I_PSUM(I_PSUM), .O_SAT(O_SAT))
	cfl1(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_x(i_x),
		.i_w(i_w),
		.i_psum(r_psum1),
		.o_psum(r_psum2));

generate_d_ff #(.D(O_SAT), .N(27))
	gdf1(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_data(r_psum2),
		.o_data(r_psum3)); 

convolution_first_line #(.I_X(I_X), .I_W(I_W), .I_PSUM(I_PSUM), .O_SAT(O_SAT))
	cfl2(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_x(i_x),
		.i_w(i_w),
		.i_psum(r_psum3),
		.o_psum(r_psum4));

generate_d_ff #(.D(O_SAT), .N(27))
	gdf2(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_data(r_psum4),
		.o_data(r_psum5)); 

convolution_first_line #(.I_X(I_X), .I_W(I_W), .I_PSUM(I_PSUM), .O_SAT(O_SAT))
	cfl3(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_x(i_x),
		.i_w(i_w),
		.i_psum(r_psum5),
		.o_psum(r_psum6));

generate_d_ff #(.D(O_SAT), .N(27))
	gdf3(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_data(r_psum6),
		.o_data(r_psum7)); 

convolution_first_line #(.I_X(I_X), .I_W(I_W), .I_PSUM(I_PSUM), .O_SAT(O_SAT))
	cfl4(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_x(i_x),
		.i_w(i_w),
		.i_psum(r_psum7),
		.o_psum(o_psum));

endmodule

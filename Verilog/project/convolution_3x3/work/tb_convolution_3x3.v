`timescale 1ns/1ns

module tb_convolution_3x3;
parameter I_BW=19, O_BW=19, X_BW=8, W_BW=8, DFF_BW=19, DFF_TIMES=27;

reg i_clk, i_rst_n;
reg signed [X_BW-1:0] i_x;
reg signed [W_BW-1:0] i_w;
reg signed [I_BW-1:0] i_psum;
wire signed [O_BW-1:0] o_y;

convolution_3x3
#(.I_BW(I_BW), .O_BW(O_BW), .X_BW(X_BW), .W_BW(W_BW), .DFF_BW(DFF_BW), .DFF_TIMES(DFF_TIMES))
(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(i_psum),
	.o_y(o_y));


initial begin
i_clk=0;
i_rst_n=0;
i_x=0;
i_w=0;
i_psum=0;

@(posedge i_clk);
#1 i_rst_n=1;
@(posedge i_clk);
#1 	i_x=8'd100; i_w=8'd50; i_psum=16'd100;
#10 i_x=8'd10; i_w=8'd5;
#10 i_x=8'd10; i_w=8'd5;
#10 i_x=8'd10; i_w=8'd5;
#10 i_x=8'd10; i_w=8'd5;
#30 i_x=0; i_w=0; i_psum=0;



repeat(20)@(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule


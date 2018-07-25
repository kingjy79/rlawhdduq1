`timescale 1ns/1ns

module tb_convolution;
parameter I_X=8, I_W=8, I_PSUM=16, O_SAT=16;

reg i_clk, i_rst_n;
reg signed [I_X-1:0] i_x;
reg signed [I_W-1:0] i_w;
reg signed [I_PSUM-1:0] i_psum;
wire signed [O_SAT-1:0] o_psum;

convolution
#(.I_X(I_X), .I_W(I_W), .I_PSUM(I_PSUM),  .O_SAT(O_SAT) )
con0 (
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_x(i_x),
	.i_w(i_w),
	.i_psum(i_psum),
	.o_psum(o_psum));


initial begin
i_clk=0;
i_rst_n=0;
i_x=0;
i_w=0;
i_psum=0;

@(posedge i_clk);
#1 i_rst_n=1;
@(posedge i_clk);
#1 	i_x=8'd10; i_w=8'd5; 
#10000 i_x=0; i_w=0; i_psum=0;



repeat(100)@(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule

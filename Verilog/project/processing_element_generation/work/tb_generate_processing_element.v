`timescale 1ns/1ns
module tb_generate_processing_element;
parameter BW1=16, BW2=17, N=17, XW=8, WW=8, D=3;
reg i_clk, i_rst_n;
reg signed [XW-1:0] i_x;
reg signed [WW-1:0] i_w;
reg signed [BW1-1:0] i_psum;
wire signed [BW2-1:0] o_psum;

generate_processing_element
#(.BW1(BW1), .BW2(BW2), .N(N), .XW(XW), .WW(WW), .D(D)) gpe0
(
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
#1 	i_x=8'd100; i_w=8'd50; i_psum=16'd100;
#10 i_x=8'd10; i_w=8'd16; i_psum=16'd5;
#10 i_x=8'd20; i_w=8'd50; i_psum=16'd1;
#30 i_x=0; i_w=0; i_psum=0;



repeat(5) @(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule

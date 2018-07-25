`timescale 1ns/1ns

module tb_d_ff;
parameter D=16;
reg i_clk;
reg i_rst_n;
reg [D-1:0] i_data;
wire [D-1:0] o_data;

d_ff #(.D(D))
	dff0(
		.i_clk(i_clk),
		.i_rst_n(i_rst_n),
		.i_data(i_data),
		.o_data(o_data)
		);

initial begin
i_clk=0;
i_rst_n=0;
i_data=0;
@(posedge i_clk);
#1 i_rst_n=1;
@(posedge i_clk);
#1	i_data=5'h0F;
#10 i_data=6'h3A;
repeat (2) @(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule


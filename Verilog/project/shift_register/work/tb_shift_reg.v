module tb_shift_reg;
reg i_clk, i_rst_n;
reg i_load;
reg [4-1:0] i_data;
wire o_data;

shift_reg //#(.())
	sr0(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_load(i_load),
	.i_data(i_data),
	.o_data(o_data) );

initial begin
i_clk=0;
i_rst_n=0;
i_load=0;
i_data=0;

@(posedge i_clk);
#1 i_rst_n=1;
@(posedge i_clk);
#1 	i_load=1'b1; i_data=4'hA;

repeat(8)@(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule


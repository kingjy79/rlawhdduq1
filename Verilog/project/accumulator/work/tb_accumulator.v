`timescale 1ns/1ns
module tb_accumulator;
reg i_clk, i_rst_n, i_valid;
reg signed [7:0] i_x;
wire signed [11:0] o_acc;
wire o_valid;

accumulator acc (
.i_clk(i_clk),
.i_rst_n(i_rst_n),
.i_valid(i_valid),
.i_x(i_x),
.o_acc(o_acc),
.o_valid(o_valid));

initial begin
i_clk=0;
i_rst_n=0;
i_x=0;
i_valid=0;
@(posedge i_clk);
#1 i_rst_n=1;
@(posedge i_clk);
#10 i_x=12'h001; i_valid=1;
repeat(40) @(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule

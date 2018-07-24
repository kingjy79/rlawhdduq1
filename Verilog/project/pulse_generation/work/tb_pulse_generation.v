`timescale 1ns/1ns
module tb_pulse_generation;
//#(parameter)

reg i_clk, i_rst_n;
wire o_pulse;

pulse_generation pg0(
.i_clk(i_clk),
.i_rst_n(i_rst_n),
.o_pulse(o_pulse));

initial begin
i_clk=0;
i_rst_n=0;

@(posedge i_clk);
#1 i_rst_n=1;
repeat (1000) @(posedge i_clk);
$finish;
end

always #20 i_clk=~i_clk;


endmodule

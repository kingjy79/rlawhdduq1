`timescale 1ns/1ns
module tb_timer_mealy;
reg i_clk, i_rst_n, i_start, i_we;
reg [1:0] i_addr;
reg [16-1:0] i_wdata;
wire o_pwm, o_timer_end;

timer_mealy timer0(
	.i_clk(i_clk),
	.i_rst_n(i_rst_n),
	.i_start(i_start),
	.i_we(i_we),
	.i_addr(i_addr),
	.i_wdata(i_wdata),
	.o_pwm(o_pwm),
	.o_timer_end(o_timer_end));
/*
decoder_2bit dec_number(
		.i_addr(i_addr),
		.i_we(i_we),
		.o_decoder(enable_to_dcount));
*/
initial begin
i_clk=0;
i_rst_n=0;
i_start=0;
i_we=0;
i_addr=0;
i_wdata=0;

@(posedge i_clk);
#1 i_rst_n=1;
@(posedge i_clk);
#1	i_we=1; i_addr=2'd0; i_wdata=16'd20;
#10 i_we=1; i_addr=2'd1; i_wdata=16'd10;
#10 i_we=1; i_addr=2'd2; i_wdata=16'd2;
#10	i_we=0; i_addr=2'd0; i_wdata=16'd0;
@(posedge i_clk);
#1	i_start=1;
#10	i_start=0;

repeat(30) @(posedge i_clk);
#1 i_start=1;
#10 i_start=0;
repeat(20) @(posedge i_clk);
#1 i_start=1;
#10 i_start=0;
repeat(20) @(posedge i_clk);
#1 i_start=1;
#10 i_start=0;
repeat(100) @(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule


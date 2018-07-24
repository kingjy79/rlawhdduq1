`timescale 1ns/1ns

module tb_saturation;
parameter N=8, K=5;
reg signed [N-1:0] i_data;
wire signed [K-1:0] o_data;

saturation #(.N(N), .K(K)) sat(
.i_data(i_data),
.o_data(o_data));

initial begin
i_data=0;

#1 	i_data=8'd125;
#10 i_data=-8'd125;
#10	i_data=8'd100;
#10
$finish;
end
endmodule

`timescale 1ns/1ns

module tb_saturation;
parameter N=5, K=3;
reg signed [N-1:0] i_data;
wire signed [K-1:0] o_data;

saturation #(.N(N), .K(K)) sat(
.i_data(i_data),
.o_data(o_data));

initial begin
i_data=0;

#1 	i_data=5'b1;
#10 i_data=5'd2;
#10 i_data=5'd3;
#10 i_data=5'd4;
#10 i_data=5'd5;
#10 i_data=5'd6;
#10 i_data=5'd7;
#10 i_data=5'd8;
#10 i_data=5'd9;
#10 i_data=5'd10;
#10 i_data=5'd11;
#10 i_data=5'd12;
#10 i_data=5'd13;
#10 i_data=5'd14;
#10 i_data=5'd15;
#10 i_data=5'd0;
#10 i_data=-5'd1;
#10 i_data=-5'd2;
#10 i_data=-5'd3;
#10 i_data=-5'd4;
#10 i_data=-5'd5;
#10 i_data=-5'd6;
#10 i_data=-5'd7;
#10 i_data=-5'd8;
#10 i_data=-5'd9;
#10 i_data=-5'd10;
#10 i_data=-5'd11;
#10 i_data=-5'd12;
#10 i_data=-5'd13;
#10 i_data=-5'd14;
#10 i_data=-5'd15;
#10 i_data=-5'd16;
#10
$finish;
end
endmodule

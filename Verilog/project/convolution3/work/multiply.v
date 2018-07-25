module multiply
#(parameter I_X0=1, I_X1=1, O_Y0=1)
(
input signed [I_X0-1:0] i_x0,
input signed [I_X1-1:0] i_x1,
output reg signed [O_Y0-1:0] o_y0);


always @(*) begin
	o_y0= i_x0*i_x1;
	end

endmodule

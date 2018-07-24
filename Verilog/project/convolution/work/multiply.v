module multiply
#(parameter XW=8, WW=8)
(
input signed [XW-1:0] i_x,
input signed [WW-1:0] i_w,
output reg signed [XW+WW-1:0] o_multiply);


always @(*) begin
	o_multiply= i_x*i_w;
	end

endmodule

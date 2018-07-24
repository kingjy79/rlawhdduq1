module adder
#(parameter BW1=1, BW2=1)
(
input signed [16-1:0] i_data,
input signed [BW1-1:0] i_psum,
output reg signed [BW2-1:0] o_data);

always @(*) begin
	o_data=i_data+i_psum;
	end

endmodule

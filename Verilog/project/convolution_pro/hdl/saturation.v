module saturation
#(parameter I=19, O=16)(
input signed [I-1:0] i_data,
output reg signed [O-1:0] o_data);//k is smaller than I_BW

reg signed [O-1:0] max = {1'b0,{(I-O){1'b0}},{(O-1){1'b1}}};//max 비트 수 써
reg signed [O-1:0] min = {1'b1,{(I-O){1'b1}},{(O-1){1'b0}}}; //min


always @(*) begin //{O_BW{1'b1}} fill 1bit until O_BW_bit.
	if(max<=i_data) begin
		o_data=max;
		end
	else if(i_data<=min) begin
		o_data=min;
		end
	else begin
		o_data={i_data[I-1],i_data[O-2:0]};
		end
	end

endmodule


	

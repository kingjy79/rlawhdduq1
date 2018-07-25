module saturation
#(parameter I=19, O=16)(
input signed [I-1:0] i_data,
output reg signed [O-1:0] o_data);//k is smaller than I_BW

reg signed [O-1:0] max = {1'b0,{(I-O){1'b0}},{(O-1){1'b1}}};//max 비트 수 써
reg signed [O-1:0] min = {1'b1,{(I-O){1'b1}},{(O-1){1'b0}}}; //min
/*
always @(*) begin //{O_BW{1'b1}} fill 1bit until O_BW_bit.
	if(i_data[I-1]==0) begin //positive input
		if({1'b0,{(O-1){1'b1}}}<=i_data) begin //여기는 bit수를 맞추지 않더라도 괜찮고, 오히려 안쓰는게 compact하게 design 가능하다..
			o_data={1'b0,{(O-1){1'b1}}};
			end
		else begin
			//o_data={i_data[I-1],i_data[O-2:0]};
			o_data={1'b0,i_data[O-2:0]};
			end
		end
	else begin
		if(i_data<={1'b1,{(I-O){1'b1}},{(O-1){1'b0}}}) begin //연산을 할때 bit수를 맞춰주는 것이 좋다..안맞게 되면 넘어가는 비트 무시한다.
			//when ALU, it is better meet number of bits. unless that, it don't care over_bit.
			o_data={1'b1,{(O-1){1'b0}}};
			end
		else begin
			//o_data={i_data[I-1],i_data[O-2:0]};
			o_data={1'b1,i_data[O-2:0]};
			end
		end
	end
*/


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


	

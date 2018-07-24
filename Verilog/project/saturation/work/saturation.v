module saturation
#(parameter N=1, K=1)(
input signed [N-1:0] i_data,
output reg signed [K-1:0] o_data);//k is smaller than N

reg signed max = {1'b0,{(N-K){1'b0}},{(K-1){1'b1}}};//max
reg signed min = {1'b1,{(N-K){1'b1}},{(K-1){1'b0}}}; //min
/*
always @(*) begin //{K{1'b1}} fill 1bit until K_bit.
	if(i_data[N-1]==0) begin //positive input
		if({1'b0,{(K-1){1'b1}}}<=i_data) begin //여기는 bit수를 맞추지 않더라도 괜찮고, 오히려 안쓰는게 compact하게 design 가능하다..
			o_data={1'b0,{(K-1){1'b1}}};
			end
		else begin
			o_data={i_data[N-1],i_data[K-2:0]};
			end
		end
	else begin
		if(i_data<={1'b1,{(N-K){1'b1}},{(K-1){1'b0}}}) begin //연산을 할때 bit수를 맞춰주는 것이 좋다..안맞게 되면 넘어가는 비트 무시한다.
			//when ALU, it is better meet number of bits. unless that, it don't care over_bit.
			o_data={1'b1,{(K-1){1'b0}}};
			end
		else begin
			o_data={i_data[N-1],i_data[K-2:0]};
			end
		end
	end
*/	


always @(*) begin //{K{1'b1}} fill 1bit until K_bit.
	if(max<=i_data) begin
		o_data=max;
		end
	else if(i_data<=min) begin
		o_data=min;
		end
	else begin
		o_data={i_data[N-1],i_data[K-2:0]};
		end
	end

endmodule


	

module control
//#(parameter  I_W=8)
(
	input i_clk, i_rst_n,
	input i_valid,
	output reg o_valid
	);



reg [4:0] row; //33개 사
reg [4:0] column;


always @(posedge i_clk, negedge i_rst_n) begin 
if(!i_rst_n) begin  //stop reset
	row<=0;
	column<=0;
 	end
else begin
	if(i_valid==1) begin
		if(row==31) begin
			row <= 0;
			if(column==31) begin
				column <= 0;
				end
			else begin
				column <= column + 1;
				end
			end
		else begin
			row<=row+1;
		end
		end
  	end
end

always @(*) begin
	if(i_valid) begin
		if((row<=27)&&(column<=27)) begin
			o_valid = 1;
			end
		else begin
			o_valid = 0;
			end
		end
	else begin
		o_valid = 0;
		end
	end
endmodule			

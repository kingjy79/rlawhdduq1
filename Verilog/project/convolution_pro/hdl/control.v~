module control
//#(parameter  I_W=8)
(
	input i_clk, i_rst_n,
	input i_valid,
	output reg o_valid
	);



reg [4:0] row;
reg [4:0] column;

always @(posedge i_clk, negedge i_rst_n) begin 
if(!i_rst_n) begin  //stop reset
	o_valid<=0;
	row<=0;
	column<=0;
 	end
else begin
	if(i_valid==1) begin
		row<=row+1;
		if(row>=31) begin
			row<=0;
			column<=column+1;
			end
		
		end

  	end
end

always @(*) begin
	if(i_valid==1) begin
		if(row<28) begin
			if(column<28) begin
				o_valid=1;
				end
			end
		else begin
			o_valid=0;
			if(column==0&&row==0) begin
				column=0;
				end
			end
			
		end
	else o_valid=0;
	end
	

endmodule			

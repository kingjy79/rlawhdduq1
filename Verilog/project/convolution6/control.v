module control
//#(parameter  I_W=8)
(
	input i_clk, i_rst_n,
	input i_valid,
	output reg o_valid
	);



reg [9:0] count;


always @(posedge i_clk, negedge i_rst_n) begin 
if(!i_rst_n) begin  //stop reset
	o_valid<=0;
	count<=0;
 	end
else begin
	if(i_valid==1) begin
		count<=count+1;
		end
  	end
end

always @(*) begin
	if(i_valid) begin
		if(count<892) begin
			if((count%32)<28) begin
				o_valid=1;
				end
			else if((count%32)<32) begin
				o_valid=0;
				end
			end
		else if(count<1024)begin 
			o_valid=0;
			end
		else begin //count>=1024
			count=0; //initialization
			end
		end
	else begin
		o_valid=0;
		end
	end

endmodule			

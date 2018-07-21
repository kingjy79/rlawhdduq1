module accumulator(
input i_clk, i_rst_n, i_valid,
input signed [7:0] i_x,
output reg signed [11:0] o_acc,
output reg o_valid);

reg signed [11:0] x_temp;
reg [3:0] count;
always @(posedge i_clk, negedge i_rst_n) 
  	begin
    	if(!i_rst_n) begin
      		count<=0;
      		x_temp<=0;
      		o_acc<=0;
      		o_valid<=0;
      		end
    	else begin
    		x_temp=i_x;
    		o_valid<=0;
    		if(i_valid==1)
    			if(count<15) begin
    				x_temp<=x_temp+count;
    				count<=count+1;
    				end
    			else begin //count==16
    				o_acc<=x_temp;
    				o_valid<=1;
    				count<=0;
    				x_temp<=0;
    				end
    		else begin
    			o_acc<=0;
    			x_temp<=0;
    			end
    		end
  		end
endmodule

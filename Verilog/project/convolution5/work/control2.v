module control
//#(parameter  I_W=8)
(
	input i_clk, i_rst_n,
	input i_valid,
	output reg o_valid
	);



reg [4:0] row;
reg [4:0] cloumn;


always @(posedge i_clk, negedge i_rst_n) begin 
if(!i_rst_n) begin  //stop reset
	o_valid<=0;
	row<=0;
	cloumn<=0;
 	end
else begin
	if(i_valid==1) begin
		row<=row+1;
		end
  	end
end

always @(*) begin
	if(i_valid) begin
		if(cloumn<28) begin
			if(row<28) begin
				o_valid=1;
				end
			else if(row<32) begin
				o_valid=0;
				end
			end
		else if(cloumn<32)begin 
			o_valid=0;
			end
		else begin //cloumn>=32
			row=0;
			cloumn=0; //initialization
			end
		end
	else begin
		o_valid=0;
		end
	end

endmodule			

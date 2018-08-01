module control
//#(parameter  I_W=8)
(
	input i_clk, i_rst_n,
	input i_valid,
	output reg o_valid);

localparam S0=3'd0,S1=3'd1;
reg c_state,n_state;
reg [8:0] row,column;


always @(posedge i_clk, negedge i_rst_n) begin 
if(!i_rst_n) begin  //stop reset
	o_valid<=0;
	row<=0;
	column<=0;
 	end
else begin
  	c_state<=n_state;
  	end
end

always @(*) begin
	case(c_state)
		S0:begin
			o_valid=0;
			if(i_valid==1) begin
				n_state=S1;
				end
			else begin
				n_state=S0;
				end
			end
		S1:begin //getting weight value form input.
			if(column<28) begin
				if(row<28) begin
					o_valid=1;
					row=row+1;
					end
				else if(row<32) begin
					o_valid=0;
					row=row+1;
					end
				else begin//row>=32
					column=column+1;
					row=0;
					end
				n_state=S1;	
				end
				
			else if (column <32) begin// column>=28 
				if(row<32) begin
					o_valid=0;
					row=row+1;
					end
				else begin//row>=32
					column=column+1;
					row=0;
					end
				n_state=S1;	
				end
			else begin //column>=32
				o_valid=0;
				n_state=S0;
				end
			end
		default begin
			o_valid=0;
			n_state=S0;
			end
		endcase
	end		
endmodule			

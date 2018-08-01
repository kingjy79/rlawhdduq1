module convolution_input
//#(parameter  I_W=8)
(
	input i_clk, i_rst_n,
	input [8-1:0] i_w,
	input i_wr_en, i_valid,
	input [5-1:0] i_addr, 
	output [8-1:0] o_w [0:25-1] );

localparam S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3;
reg [1:0] c_state,n_state;
reg [8-1:0] r_w [0: 25-1];
reg [8:0] count,column;


always @(posedge i_clk, negedge i_rstn) begin 
if(!i_rstn) begin  //stop reset
	o_w<=0;
  	c_state<=S0;
  	n_state<=S0;
 	count<=0;
 	column<=0;
 	r_w<=0;
 	end
else begin
  	c_state<=n_state;
  	count<=count+1;
  	end
  else begin 
  	count <= 0;
  	end
  end
end

always @* begin
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
			o_valid=0;
				if(count<25) begin //count is weight's size.
					r_w[count]=i_addr[count];
					n_state=S1;
					end
				else begin //count>=25
					count=0;
					n_state=S2;
					end
				end
		S2:begin
			o_valid=0;
			if(i_wr_en==1) begin
				n_state=S3;
				end
			else begin // i_wr_en==0
				n_state=S1;
				end
			end
		S3:begin
			if(column<28) begin
				if(count<28) begin
					o_valid=1;
					end
				else if(/* count>=28 && */count<32) begin //count>=28
					o_valid=0;
					end
				else begin// count>=32
					count=0;
					column=column+1;
					end
				end
			else if(column<32) begin //column>=28
				if(count<32) begin
					o_valid=0;
					end
				else begin// count>=32
					count=0;
					column=column+1;
					end
				end
			else begin // column>=32
				o_valid=0;
				n_state=S0;
				end
			end
		endcase
	end		
endmodule			

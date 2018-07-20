module lab7_doorlock(
input i_clk, i_rstn,
input i_data,
input i_start,
output o_data);

localparam S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4,S5=3'd5, S6=3'd6;
reg [2:0] c_state,n_state;
reg o_data_reg;
reg [7-1:0] count;
always @(posedge i_clk, negedge i_rstn) begin 
if(!i_rstn) begin  //stop reset
  c_state<=S6;
  count<=0;
  end
else begin
  c_state<=n_state;
  if(n_state==S4) count<=count+1;
  else count <= 0;
  end
end

always @(*) begin
case(c_state)
  S0:begin
  o_data_reg=1'b0;
  if(i_data==1)
    n_state=S1;
  else
    n_state=S0;
  end

  S1:begin
  o_data_reg=1'b0;
  if(i_data==1)
    n_state=S5;
  else
    n_state=S2;
  end

  S2:begin
  o_data_reg=1'b0;
  if(i_data==1)
    n_state=S3;
  else
    n_state=S0;
  end

  S3:begin
  o_data_reg=1'b0;
  if(i_data==1)
    n_state=S4;
  else
    n_state=S2;
  end

  S4:begin
  o_data_reg=1'b1;
  if(count<100)
    n_state=S4; //remain value:1
  else if(count==100) 
    n_state=S6;
  end

  S5:begin
  o_data_reg=1'b0;
  if(i_data==1)
    n_state=S5;
  else
    n_state=S0;
  end

  S6:begin
  o_data_reg=1'b0;
  if(i_start==1)
    n_state=S0;
  else
    n_state=S6;
  end

endcase
end

assign o_data=o_data_reg;


endmodule

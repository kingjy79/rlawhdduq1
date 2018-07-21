`timescale 10ns/10ns

module decoder_2bit
(
input [2-1:0] i_addr,
input i_we,
output reg [2**2-1:0] o_decoder);

always @(*) begin
  if(i_we==1'b1) begin
    if(i_addr==2'b00)
      o_decoder=4'b0001;
    else if(i_addr==2'b01)
      o_decoder=4'b0010;
    else if(i_addr==2'b10)
      o_decoder=4'b0100;
    else
      o_decoder=4'h0;
    end
  else
    o_decoder=4'h0;
  end

endmodule



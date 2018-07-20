`timescale 10ns/10ns

module tb_decoder_2bit;
reg [1:0] i_addr;
reg i_we;
wire [3:0] o_decoder;

decoder_2bit dec_2(
.i_addr(i_addr),
.i_we(i_we),
.o_decoder(o_decoder));

initial
  begin
    #1
    i_addr=2'b00;
    i_we=1'b0;
    #10
    i_addr=2'b01;
    i_we=1'b0;
    #10
    i_addr=2'b10;
    i_we=1'b0;
    #10
    i_addr=2'b11;
    i_we=1'b0;
    #10
    i_addr=2'b00;
    i_we=1'b1;
    #10
    i_addr=2'b01;
    i_we=1'b1;
    #10
    i_addr=2'b10;
    i_we=1'b1;
    #10
    i_addr=2'b11;
    i_we=1'b1;
    #10
    i_addr=2'b00;
    i_we=1'b0;
    

    #10
    $finish;
  end

endmodule


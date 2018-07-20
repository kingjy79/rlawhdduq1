module tb_lab7_doorlook;
reg i_clk, i_rstn, i_data,i_start;
wire o_data;

lab7_doorlock ddd(
.i_clk(i_clk),
.i_rstn(i_rstn),
.i_data(i_data),
.i_start(i_start),
.o_data(o_data));

initial begin
i_clk=0;
i_rstn=0;
i_data=0;
i_start=0;
@(posedge i_clk);
#1 i_rstn=1;
@(posedge i_clk);
#10 i_data=0;
    i_start=1;
#10 i_data=1;
    i_start=0;
#10 i_data=0;
#10 i_data=0;
#10 i_data=1;
#10 i_data=0;
#10 i_data=1;
#10 i_data=1;
#10 i_data=0;

repeat(1000) @(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule



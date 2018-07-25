module tb_generate_d_ff;

parameter N=8,D=6;
reg i_clk, i_rstn;
reg [N-1:0] i_data;
wire [N-1:0] o_data;

generate_d_ff #(N,D) g_d_ff(
.i_clk(i_clk),
.i_rstn(i_rstn),
.i_data(i_data),
.o_data(o_data));

initial begin
i_clk=0;
i_rstn=0;
i_data=0;
@(posedge i_clk);
#1 i_rstn=1;
@(posedge i_clk);
#13 i_data=4'b0111;
repeat(10) @(posedge i_clk);
$finish;
end

always #5 i_clk=~i_clk;

endmodule

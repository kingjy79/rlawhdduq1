module store_weight

(
	input i_clk, i_rst_n,
	input signed [7:0] i_w,
	input [4:0] i_addr,
	input i_wr_en,
	input i_valid,
	output reg signed[7:0] o_w0,
	output reg signed[7:0] o_w1,
	output reg signed[7:0] o_w2,
	output reg signed[7:0] o_w3,
	output reg signed[7:0] o_w4,
	output reg signed[7:0] o_w5,
	output reg signed[7:0] o_w6,
	output reg signed[7:0] o_w7,
	output reg signed[7:0] o_w8,
	output reg signed[7:0] o_w9,
	output reg signed[7:0] o_w10,
	output reg signed[7:0] o_w11,
	output reg signed[7:0] o_w12,
	output reg signed[7:0] o_w13,
	output reg signed[7:0] o_w14,
	output reg signed[7:0] o_w15,
	output reg signed[7:0] o_w16,
	output reg signed[7:0] o_w17,
	output reg signed[7:0] o_w18,
	output reg signed[7:0] o_w19,
	output reg signed[7:0] o_w20,
	output reg signed[7:0] o_w21,
	output reg signed[7:0] o_w22,
	output reg signed[7:0] o_w23,
	output reg signed[7:0] o_w24
	
);

always @(posedge i_clk, negedge i_rst_n) begin
	if(!i_rst_n) begin
		o_w0<=0;
		o_w1<=0;
		o_w2<=0;
		o_w3<=0;
		o_w4<=0;
		o_w5<=0;
		o_w6<=0;
		o_w7<=0;
		o_w8<=0;
		o_w9<=0;
		o_w10<=0;
		o_w11<=0;
		o_w12<=0;
		o_w13<=0;
		o_w14<=0;
		o_w15<=0;
		o_w16<=0;
		o_w17<=0;
		o_w18<=0;
		o_w19<=0;
		o_w20<=0;
		o_w21<=0;
		o_w22<=0;
		o_w23<=0;
		o_w24<=0;
		end
	else if(i_valid==1) begin
		if(i_wr_en==1 && i_addr==5'd0) o_w0<=i_w;
		else if(i_wr_en==1 && i_addr==5'd1) o_w1<=i_w;
		else if(i_wr_en==1 && i_addr==5'd2) o_w2<=i_w;
		else if(i_wr_en==1 && i_addr==5'd3) o_w3<=i_w;
		else if(i_wr_en==1 && i_addr==5'd4) o_w4<=i_w;
		else if(i_wr_en==1 && i_addr==5'd5) o_w5<=i_w;
		else if(i_wr_en==1 && i_addr==5'd6) o_w6<=i_w;
		else if(i_wr_en==1 && i_addr==5'd7) o_w7<=i_w;
		else if(i_wr_en==1 && i_addr==5'd8) o_w8<=i_w;
		else if(i_wr_en==1 && i_addr==5'd9) o_w9<=i_w;
		else if(i_wr_en==1 && i_addr==5'd10) o_w10<=i_w;
		else if(i_wr_en==1 && i_addr==5'd11) o_w11<=i_w;
		else if(i_wr_en==1 && i_addr==5'd12) o_w12<=i_w;
		else if(i_wr_en==1 && i_addr==5'd13) o_w13<=i_w;
		else if(i_wr_en==1 && i_addr==5'd14) o_w14<=i_w;
		else if(i_wr_en==1 && i_addr==5'd15) o_w15<=i_w;
		else if(i_wr_en==1 && i_addr==5'd16) o_w16<=i_w;
		else if(i_wr_en==1 && i_addr==5'd17) o_w17<=i_w;
		else if(i_wr_en==1 && i_addr==5'd18) o_w18<=i_w;
		else if(i_wr_en==1 && i_addr==5'd19) o_w19<=i_w;
		else if(i_wr_en==1 && i_addr==5'd20) o_w20<=i_w;
		else if(i_wr_en==1 && i_addr==5'd21) o_w21<=i_w;
		else if(i_wr_en==1 && i_addr==5'd22) o_w22<=i_w;
		else if(i_wr_en==1 && i_addr==5'd23) o_w23<=i_w;
		else if(i_wr_en==1 && i_addr==5'd24) o_w24<=i_w;
		end
	else begin
		o_w0<=0;
		o_w1<=0;
		o_w2<=0;
		o_w3<=0;
		o_w4<=0;
		o_w5<=0;
		o_w6<=0;
		o_w7<=0;
		o_w8<=0;
		o_w9<=0;
		o_w10<=0;
		o_w11<=0;
		o_w12<=0;
		o_w13<=0;
		o_w14<=0;
		o_w15<=0;
		o_w16<=0;
		o_w17<=0;
		o_w18<=0;
		o_w19<=0;
		o_w20<=0;
		o_w21<=0;
		o_w22<=0;
		o_w23<=0;
		o_w24<=0;
		end
	end
endmodule

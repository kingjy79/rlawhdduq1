module convolution_top_module
#(parameter I_X=8, I_W=8, I_PSUM=16, O_SAT=16)//not yet
(
input iCLK, iRSTn,
input signed [7:0] iW, iX,
input [4:0] iADDR,
input iWren, iValid,

output signed [15:0] oY,
output oValid);


wire r_valid0;
wire r_valid1;

wire [7:0] r_x0;

wire [7:0] r_w0;
wire [7:0] r_w1;
wire [7:0] r_w2;
wire [7:0] r_w3;
wire [7:0] r_w4;
wire [7:0] r_w5;
wire [7:0] r_w6;
wire [7:0] r_w7;
wire [7:0] r_w8;
wire [7:0] r_w9;
wire [7:0] r_w10;
wire [7:0] r_w11;
wire [7:0] r_w12;
wire [7:0] r_w13;
wire [7:0] r_w14;
wire [7:0] r_w15;
wire [7:0] r_w16;
wire [7:0] r_w17;
wire [7:0] r_w18;
wire [7:0] r_w19;
wire [7:0] r_w20;
wire [7:0] r_w21;
wire [7:0] r_w22;
wire [7:0] r_w23;
wire [7:0] r_w24;

wire [15:0] r_psum1;
wire [16:0] r_psum2;
wire [16:0] r_psum3;
wire [17:0] r_psum4;
wire [18:0] r_psum5;

wire [15:0] r_psum6;
wire [16:0] r_psum7;
wire [16:0] r_psum8;
wire [17:0] r_psum9;
wire [18:0] r_psum10;

wire [15:0] r_psum11;
wire [16:0] r_psum12;
wire [16:0] r_psum13;
wire [17:0] r_psum14;
wire [18:0] r_psum15;

wire [15:0] r_psum16;
wire [16:0] r_psum17;
wire [16:0] r_psum18;
wire [17:0] r_psum19;
wire [18:0] r_psum20;

wire [15:0] r_psum21;
wire [16:0] r_psum22;
wire [16:0] r_psum23;
wire [17:0] r_psum24;
wire [18:0] r_psum25;

wire [15:0] r_sat0;
wire [15:0] r_sat1;
wire [15:0] r_sat2;
wire [15:0] r_sat3;
//wire [15:0] r_sat4;

wire [15:0] r_gen0;
wire [15:0] r_gen1;
wire [15:0] r_gen2;
wire [15:0] r_gen3;



store_weight
	sw0(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_w(iW),
		.i_addr(iADDR),
		.i_wr_en(iWren),
		.i_valid(iValid),
		.o_w0(r_w0),
		.o_w1(r_w1),
		.o_w2(r_w2),
		.o_w3(r_w3),
		.o_w4(r_w4),
		.o_w5(r_w5),
		.o_w6(r_w6),
		.o_w7(r_w7),
		.o_w8(r_w8),
		.o_w9(r_w9),
		.o_w10(r_w10),
		.o_w11(r_w11),
		.o_w12(r_w12),
		.o_w13(r_w13),
		.o_w14(r_w14),
		.o_w15(r_w15),
		.o_w16(r_w16),
		.o_w17(r_w17),
		.o_w18(r_w18),
		.o_w19(r_w19),
		.o_w20(r_w20),
		.o_w21(r_w21),
		.o_w22(r_w22),
		.o_w23(r_w23),
		.o_w24(r_w24)
		);

generate_d_ff #(.D(16), .N(1))
	dff0(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_data(iX),
		.o_data(r_x0)
		);

//assign r_x0=iX;

generate_d_ff #(.D(16), .N(1))
	dff1(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_data(iValid),
		.o_data(r_valid0)
		);

//assign r_valid0=iValid;
control
		ct0(
			.i_clk(iCLK),
			.i_rst_n(iRSTn),
			.i_valid(r_valid0),
			.o_valid(r_valid1)
			);

generate_d_ff #(.D(16), .N(133))
	gdf_ct0(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_data(r_valid1),
		.o_data(oValid) );

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(16), .O_PSUM(16), 
						.D(16)
						)
					pe0(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w0),
						.i_psum(0),
						.o_psum(r_psum1)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe1(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w1),
						.i_psum(r_psum1),
						.o_psum(r_psum2)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe2(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w2),
						.i_psum(r_psum2),
						.o_psum(r_psum3)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(18), .O_PSUM(18), 
						.D(18)
						)
					pe3(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w3),
						.i_psum(r_psum3),
						.o_psum(r_psum4)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(18), 
						.O_MULTIPLY(16), .O_ADDER(19), .O_PSUM(19), 
						.D(19)
						)
					pe4(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w4),
						.i_psum(r_psum4),
						.o_psum(r_psum5)
						);

saturation #(.I(19), .O(16))
			sat0(
				.i_data(r_psum5),
				.o_data(r_sat0)
				);

generate_d_ff #(.D(16), .N(27))
	gdf0(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_data(r_sat0),
		.o_data(r_gen0) ); //finish first line.

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(16), .O_PSUM(16), 
						.D(16)
						)
					pe5(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w5),
						.i_psum(r_gen0),
						.o_psum(r_psum6)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe6(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w6),
						.i_psum(r_psum6),
						.o_psum(r_psum7)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe7(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w7),
						.i_psum(r_psum7),
						.o_psum(r_psum8)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(18), .O_PSUM(18), 
						.D(18)
						)
					pe8(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w8),
						.i_psum(r_psum8),
						.o_psum(r_psum9)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(18), 
						.O_MULTIPLY(16), .O_ADDER(19), .O_PSUM(19), 
						.D(19)
						)
					pe9(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w9),
						.i_psum(r_psum9),
						.o_psum(r_psum10)
						);

saturation #(.I(19), .O(16))
			sat1(
				.i_data(r_psum10),
				.o_data(r_sat1)
				);

generate_d_ff #(.D(16), .N(27))
	gdf1(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_data(r_sat1),
		.o_data(r_gen1) ); //finish second line.

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(16), .O_PSUM(16), 
						.D(16)
						)
					pe10(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w10),
						.i_psum(r_gen1),
						.o_psum(r_psum11)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe11(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w11),
						.i_psum(r_psum11),
						.o_psum(r_psum12)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe12(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w12),
						.i_psum(r_psum12),
						.o_psum(r_psum13)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(18), .O_PSUM(18), 
						.D(18)
						)
					pe13(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w13),
						.i_psum(r_psum13),
						.o_psum(r_psum14)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(18), 
						.O_MULTIPLY(16), .O_ADDER(19), .O_PSUM(19), 
						.D(19)
						)
					pe14(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w14),
						.i_psum(r_psum14),
						.o_psum(r_psum15)
						);

saturation #(.I(19), .O(16))
			sat2(
				.i_data(r_psum15),
				.o_data(r_sat2)
				);

generate_d_ff #(.D(16), .N(27))
	gdf2(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_data(r_sat2),
		.o_data(r_gen2) ); //finish third line.

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(16), .O_PSUM(16), 
						.D(16)
						)
					pe15(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w15),
						.i_psum(r_gen2),
						.o_psum(r_psum16)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe16(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w16),
						.i_psum(r_psum16),
						.o_psum(r_psum17)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe17(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w17),
						.i_psum(r_psum17),
						.o_psum(r_psum18)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(18), .O_PSUM(18), 
						.D(18)
						)
					pe18(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w18),
						.i_psum(r_psum18),
						.o_psum(r_psum19)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(18), 
						.O_MULTIPLY(16), .O_ADDER(19), .O_PSUM(19), 
						.D(19)
						)
					pe19(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w19),
						.i_psum(r_psum19),
						.o_psum(r_psum20)
						);

saturation #(.I(19), .O(16))
			sat3(
				.i_data(r_psum20),
				.o_data(r_sat3)
				);

generate_d_ff #(.D(16), .N(27))
	gdf3(
		.i_clk(iCLK),
		.i_rst_n(iRSTn),
		.i_data(r_sat3),
		.o_data(r_gen3) ); //finish 4th line.

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(16), .O_PSUM(16), 
						.D(16)
						)
					pe20(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w20),
						.i_psum(r_gen3),
						.o_psum(r_psum21)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(16), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe21(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w21),
						.i_psum(r_psum21),
						.o_psum(r_psum22)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(17), .O_PSUM(17), 
						.D(17)
						)
					pe22(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w22),
						.i_psum(r_psum22),
						.o_psum(r_psum23)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(17), 
						.O_MULTIPLY(16), .O_ADDER(18), .O_PSUM(18), 
						.D(18)
						)
					pe23(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w23),
						.i_psum(r_psum23),
						.o_psum(r_psum24)
						);

processing_element 	#(	.I_X(8), .I_W(8), .I_PSUM(18), 
						.O_MULTIPLY(16), .O_ADDER(19), .O_PSUM(19), 
						.D(19)
						)
					pe24(
						.i_clk(iCLK),
						.i_rst_n(iRSTn),
						.i_x(r_x0),
						.i_w(r_w24),
						.i_psum(r_psum24),
						.o_psum(r_psum25)
						);

saturation #(.I(19), .O(16))
			sat4(
				.i_data(r_psum25),
				.o_data(oY)
				); //finish last line.




endmodule

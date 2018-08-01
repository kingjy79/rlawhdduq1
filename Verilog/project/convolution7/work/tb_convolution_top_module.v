
`timescale 1ns/1ns

module tb_convolution_top_module;

	reg iCLK, iRSTn, iValid, iWren;
	reg [4:0] iADDR;
	reg signed [7:0] iX, iW;
	wire signed [15:0] oY;
	wire oValid;

	integer i, j;
	integer fpInx;
	integer fpInw;
	integer fpOut;
	integer statusRd1;
	integer statusRd2;
	
convolution_top_module convtop(
						.iCLK(iCLK),
						.iRSTn(iRSTn), 
						.iValid(iValid), 
						.iWren(iWren), 
						.iADDR(iADDR),
						.iX(iX), 
						.iW(iW),
						.oY(oY),
						.oValid(oValid) );
initial begin
	iCLK = 0;
	iRSTn = 0;
	iWren = 0;
	iValid = 0;
	iADDR = 0;
	iX = 0;
	iW = 0;
	
	
	fpInw=$fopen("../testvector/w_in_1s.dat","r");
	fpOut=$fopen("../testvector/y_out_1s.dat","w");
	@(posedge iCLK);
	#1 iRSTn = 1;
	@(posedge iCLK);
	#1 iValid=1;
	 
	 for(i=0; i<6;i=i+1)begin
	 	fpInx=$fopen("../testvector/x_in_1s.dat","r");
		for(j=0; j<1024; j=j+1) begin
			statusRd1=$fscanf(fpInx,"%d\n",iX);
			if(j<25) begin
				statusRd2=$fscanf(fpInw,"%d\n",iW);
				iWren = 1;
				iADDR = j;
			end
			else begin
			 	iW = 0;
				iWren = 0;
				iADDR = 0;
			end
			@(posedge iCLK);
		end
	end
	 
	iValid=0;
	iX = 0;
	iW = 0;
	
	repeat (5) @(posedge iCLK);
	$fclose(fpInx);
	$fclose(fpInw);
	$fclose(fpOut);
	$stop;

end

always #5 iCLK = ~iCLK;

always@(posedge iCLK)
 if(oValid)
 $fwrite(fpOut,"%d\n",oY);
 
endmodule

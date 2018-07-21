module timer(
input i_clk, i_rst_n, i_start, i_we, //Don't control input in module!!!
input [1:0] i_adder,
input [15:0] i_wdata
output reg o_pwm,o_timer_end);
// it needs bottom module that contain decoder,d_filp_flop
reg [2*2-1:0]enable_to_dcount;  //local variable

/*2bit_decoder recall
decoder_2bit dec0(
	.i_addr(i_adder),
	.i_we(i_we),
	.o_decoder(enable_to_dcount));
*/
reg [16-1:0] max_counter;
reg [16-1:0] pwm_counter;
reg [16-1:0] stop_count;


//after compile this file,I will modify this parameter to optimizition.
localparam S0=1'b0, S1=1'b1;
reg c_state, n_state; //1bit(2state)
reg [16-1:0] inner_count;
reg [7-1:0] cycle_count; //depending how much..100.
reg [3-1:0] end_count;


always @(posedge i_clk, negedge i_rst_n) begin 
	if(!i_rst_n) begin //stop reset -> driving this module.
		o_pwm<=0; //all reg initialization.
		o_timer_end<=0;
		c_state<=S0;
		n_state<=S0;
		enable_to_dcount<=0;
		max_counter<=0;
		pwm_counter<=0;
		stop_count<=0;
		inner_count<=0;
		cycle_count<=0;
		end_count<=0;
		end

	else begin
		d_ff dff_max #(N=16)(
							.i_clk(i_clk)
							.i_rst_n(i_rst_n)
							.i_data(i_wdata)
							.i_enable(enable_to_dcount[0])
							.o_data(max_counter));
		d_ff dff_pwm #(N=16)(
							.i_clk(i_clk)
							.i_rst_n(i_rst_n)
							.i_data(i_wdata)
							.i_enable(enable_to_dcount[0])
							.o_data(max_counter));
		d_ff dff_ #(N=16)(
							.i_clk(i_clk)
							.i_rst_n(i_rst_n)
							.i_data(i_wdata)
							.i_enable(enable_to_dcount[0])
							.o_data(max_counter));
		c_state<=n_state; //while Driving
		case(c_state)//this state maintain before posedge.
  			S0:begin //initial state
  				if(i_start==1) begin//S0->S1
      				if(enable_to_dcount==4'h1) begin
           				max_counter=i_wdata;
        				end
      				else if(enable_to_dcount==4'h2) begin
          				pwm_counter=i_wdata;
          				end
      				else if(enable_to_dcount==4'h4) begin
        				stop_count=i_wdata;
        				end
        			else begin//after fetch from i_wdata.
        				n_state=S1;//S0->S1 
        				end   					
   				else//i_start==0, S0->S0
      				n_state=S0;
        			end    	   
			default begin//S1
				n_state=S0; //S1->S0
    			end
      		endcase
		inner_count<=inner_count+1;//inner_count is operated for o_pwm.
		if(stop_count>=cycle_count) begin//cycle_count comfirms how many times stop_count counts.
		//it is still in progress. output is not affected by i_start. 
			if(end_count<10) begin //end_count is drived for o_time_end maintain value 1. 
				o_time_end<=1;
				end_count=end_count+1;
				end
			else begin
				o_time_end<=0;
				end

			end
			
			
		if(c_state==S1) begin
			if(pwm_count<=inner_count && inner_count<max_count) begin
				o_pwm=1;//In special range, It will have value 1 
				end
			else if(inner_count<pwm_count) begin
				o_pwm=0;
				end
			else //inner_count>=max_count
				cycle_count<=cycle_count+1;
			if(stop_count==cycle_count) begin
				o_timer_end<=1;
		end
	end

always @(*) begin //fetch? information from decoder. 
	decoder_2bit dec0(
		.i_addr(i_adder),
		.i_we(i_we),
		.o_decoder(enable_to_dcount));
	end


    	    

endmodule 



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
reg [16-1:0] pwm_count;
reg [16-1:0] pwm_count;
reg [16-1:0] stop_count;


//after compile this file,I will modify this parameter to optimizition.
localparam S0=1'b0, S1=1'b1;
reg [2-1:0] c_state, n_state; //2bit(4state)
reg [16-1:0] inner_count;
reg [7-1:0] cycle_count; //depending how much..100.
reg [3-1:0] end_count;

always @(*) begin //fetch? information from decoder.,combination curcuit
	decoder_2bit dec0(
		.i_addr(i_adder),
		.i_we(i_we),
		.o_decoder(enable_to_dcount));
		end

always @(posedge i_clk, negedge i_rst_n) begin 
	if(!i_rst_n) begin //stop reset -> driving this module.
		o_pwm<=0; //all reg initialization.
		o_timer_end<=0;
		c_state<=S0;
		n_state<=S0;
		enable_to_dcount<=0;
		pwm_count<=0;
		pwm_count<=0;
		stop_count<=0;
		inner_count<=0;
		cycle_count<=0;
		end_count<=0;
		end

	else begin//I wanted to use module d_ff, but it is expected delay 2 clocks.
      	
       	c_state<n_state;
		case(c_state)
       		S0:begin
       			if(enable_to_dcount==4'h1) begin//0001
           			pwm_count=i_wdata;
        			end
      			else if(enable_to_dcount==4'h2) begin//0010
          			pwm_count=i_wdata;
          			end
      			else if(enable_to_dcount==4'h4) begin//0100
        			stop_count=i_wdata;
        			end
    		   	else begin
      		 		pwm_count=pwm_count;
       				pwm_count=pwm_count;
       				stop_count=stop_count;
       				end  
       			if(i_start==1) begin
       				//S0->S1 Action description
       				if(cycle_count<stop_cycle) begin
        				inner_count<=inner_count+1;
        				if(inner_count<pwm_count) begin
        					o_pwm<=0;
        					end
        				else if(pwm_count<=inner_count && inner_count<max_count) begin
        					o_pwm<=1;
        				else begin//max_count<=inner_count
        					inner_count<=0;//initialization inner_count
        					cycle_count<=cycle_count+1;//when 'max_count' and 'inner_count' are equal, 'cycle_count' is incremented by one.
        					end
        			else if(stop_count<=cycle_count) begin// && cycle_count<(stop_count+10)) begin
        				o_timer_end<=1;
        				end
        			n_state<=S1;
        			else begin
        				n_state<=S1; //to avoid creating a latch
        				end
        			end
				else begin
        		//S0->S0 action description
        			n_state<=S0;
        			end
        		end
        			/*
        			else begin//(stop_count+10)<=cycle_count
        				o_timer_end<=0;
        				cycle_count<=0; //when 'stop_count+10' and 'cycle_count are equal, set cycle_count to 0	
        				end
        			*/
        	S1:begin
       			if(o_timer_end==0) begin
       				//S1->S1 Action description
       				if(cycle_count<stop_cycle) begin
        				inner_count<=inner_count+1;
        				if(inner_count<pwm_count) begin
        					o_pwm<=0;
        					end
        				else if(pwm_count<=inner_count && inner_count<max_count) begin
        					o_pwm<=1;
        				else begin//max_count<=inner_count
        					inner_count<=0;//initialization inner_count
        					cycle_count<=cycle_count+1;//when 'max_count' and 'inner_count' are equal, 'cycle_count' is incremented by one.
        					end
        			else if(stop_count<=cycle_count && cycle_count<(stop_count+10)) begin
        				o_timer_end<=1;
        				end
        			else begin
        				n_state<=S1;
        				end
        			n_state<=S1;
        			end
        		else begin//o_timer_end==1
        		//action description: S1->S2
        			if(cycle_count<(stop_count+10)) begin
        				o_timer_end<=o_time_end;
        				cycle_count<=cycle_count+1; //when 'stop_count+10' and 'cycle_count are equal, set cycle_count to 0	
        				end
        			else//stop_count+10<=cycle_count
        				o_timer_end<=0;
        				cycle_count<=0; //when 'stop_count+10' and 'cycle_count are equal, set cycle_count to 0	
        				end
					n_state<=S2;
        			end
        		end
        	S2:begin
        		if(o_timer_end==1) begin
        		//action description S2->S2
        			if(cycle_count<(stop_count+10)) begin
        				o_timer_end<=o_time_end;
        				cycle_count<=cycle_count+1; //when 'stop_count+10' and 'cycle_count are equal, set cycle_count to 0	
        				end
        			else//stop_count+10<=cycle_count
        				o_timer_end<=0;
        				cycle_count<=0; //when 'stop_count+10' and 'cycle_count are equal, set cycle_count to 0	
        				end
					n_state<=S2;
        			end
        		else begin//o_timer_end==0
        		
        			n_state<=S0;
        			end
        		end
        		else begin
        		//action description S2->S0

        			n_state<=S0;
        			end
        		end
        	default: begin
        		n_state<=S0;
        		end
        	endcase
        end
	end		
endmodule 




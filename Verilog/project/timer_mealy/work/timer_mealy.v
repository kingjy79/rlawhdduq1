module timer_mealy(
input i_clk, i_rst_n, i_start, i_we, //Don't control input in module!!!
input [1:0] i_addr,
input [15:0] i_wdata,
output reg o_pwm,o_timer_end);
// it needs bottom module that contain decoder,d_filp_flop
wire [2*2-1:0]enable_to_dcount; 


reg [16-1:0] max_count;
reg [16-1:0] pwm_count;
reg [16-1:0] stop_count;



localparam S0=2'd0, S1=2'd1, S2=2'd2;
reg [2-1:0] c_state, n_state; //2bit(4state)
reg [16-1:0] inner_count;
reg [7-1:0] cycle_count; //depending how much..100.
reg [4-1:0] end_count;

decoder_2bit dec_number(
		.i_addr(i_addr),
		.i_we(i_we),
		.o_decoder(enable_to_dcount));



always @(posedge i_clk, negedge i_rst_n) begin 
	if(!i_rst_n) begin //stop reset -> driving this module.
		o_pwm<=0; //all reg initialization.
		o_timer_end<=0;
		c_state<=S0;
		n_state<=S0;
		max_count<=0;
		pwm_count<=0;
		stop_count<=0;
		inner_count<=0;
		cycle_count<=0;
		end_count<=0;
		end

	else begin
      	
       	c_state<=n_state;
		case(c_state)
       		S0:begin
       			if(enable_to_dcount==4'h1) begin//0001
           			max_count<=i_wdata;
        			end
      			else if(enable_to_dcount==4'h2) begin//0010
          			pwm_count<=i_wdata;
          			end
      			else if(enable_to_dcount==4'h4) begin//0100
        			stop_count<=i_wdata;
        			end
    		   	else begin
      		 		max_count<=max_count;
       				pwm_count<=pwm_count;
       				stop_count<=stop_count;
       				end  

       			if(i_start==1) begin
       				n_state<=S1;
       				c_state<=S1;
       				end
       			else begin//(i_start==0)
       				n_state<=S0;
       				end
       			end
       		S1:begin
       			if(cycle_count<stop_count) begin
        				inner_count<=inner_count+1;
        				if(inner_count<pwm_count) begin
        					o_pwm<=0;
        					end
        				else if(pwm_count<=inner_count && inner_count<max_count) begin
        					o_pwm<=1;
        					end
        				else begin//max_count<=inner_count
        					inner_count<=0;//initialization inner_count
        					cycle_count<=cycle_count+1;//when 'max_count' and 'inner_count' are equal, 'cycle_count' is incremented by one.
        					end
						n_state<=S1;
						end
				else begin // stop_count<=cycle_count 
        			o_timer_end<=1;
        			o_pwm<=0;
        			n_state<=S2;
        			end
             	end
             S2:begin
        		if(o_timer_end==1) begin
        		//action description S2->S2
        			if(end_count<(10-1)) begin //start form 0, so it will drvie until 9. for 10times.
        				o_timer_end<=o_timer_end;
        				end_count<=end_count+1; 
        				end
        			else begin//9<=end_count
        				o_timer_end<=0;
        				end_count<=0; //when '10-1' and 'end_count are equal, set end_count to 0	
        				cycle_count<=0;	
        				end
					n_state<=S2;
        			end
        		else begin//o_timer_end==0
        		//action description S2->S0
        			n_state<=S0;
        			end_count<=0;
        			end
        		end
        		
        	default begin
        		n_state<=S0;
        		end
        	endcase
       	end
	end
endmodule 




module control#(
    parameter   INPUT_DEPTH = 15488,//22x22x64 = 30976, 30976/2 = 15488
                BUS_BW = 16) (
    input logic [BUS_BW-1:0] memory_access,
    input logic input_start
);

logic [2:0] next_state, current_state;
logic [13:0] count;

localparam IDLE = 0, GETTING_INPUT = 1, GETTING_WEIGHT = 2, CONVOLUTION_CALCULATION = 3, SET_PARTIAL_OUTPUT = 4,
    SAVE_OUTPUT = 5;

logic signed [INPUT_BW-1:0] input_buffer [0:INPUT_DEPTH-1];

always_ff @(posedge clk, posedge reset) begin
    if(reset) begin //reset == 1
        //reset system
        current_state <= 0;
        next_state <= 0;
        finish_getting_input <= 0;
        finish_getting_weight <= 0;
        finish_convolution_weight <= 0;
        finish_set_all_output <= 0;
        finish_save_output <= 0;
        count <= 0;
    end

    else begin
        //change state
        current_state <= next_state;
        if(next_state == GETTING_INPUT) begin
            count++;
        end
    end  
end


always_comb begin //flow
    case(current_state)

    IDLE: begin
        if(input_start) begin //input_start == 1
            next_state = GETTING_INPUT;
        end
        else begin//input_start != 1
            next_state = IDLE;
        end

    GETTING_INPUT: begin
        if(finish_getting_input) begin
            next_state = GETTING_WEIGHT;
        end
        else begin
            next_state = GETTING_INPUT;
        end

    GETTING_WEIGHT: begin
        if(finish_getting_weight) begin
            next_state = CONVOLUTION_CALCULATION;
        end
        else begin
            next_state = GETTING_WEIGHT;
        end

    CONVOLUTION_CALCULATION: begin
        if(finish_convolution_weight) begin
            next_state = SET_PARTIAL_OUTPUT;
        end
        else begin
            next_state = CONVOLUTION_CALCULATION;
        end

    SET_PARTIAL_OUTPUT: begin
        if(finish_set_all_output) begin
            next_state = SAVE_OUTPUT;
        end
        else begin
            next_state = SET_PARTIAL_OUTPUT;
        end

    SAVE_OUTPUT: begin
        if(finish_save_output) begin
            next_state = IDLE;
        end
        else begin
            next_state = SAVE_OUTPUT;
        end
    end
    endcase
end

always_comb begin // operation
    case(current_state)

    IDLE: begin
        finish_getting_input = 0;
        finish_getting_weight = 0;
        finish_convolution_weight = 0;
        finish_set_all_output = 0;
        finish_save_output = 0;
    end

    GETTING_INPUT: begin
        input_buffer[count] = memory_access;    //'input_buffer' get 16bits at a time. Maybe memory_access is adress.
        if(count == (INPUT_BW-1)) begin
            finish_getting_input = 1;
        end 

        else begin
            finish_getting_input = 0;
        end
    end
    


endmodule
module control#(
    parameter   ) (
    
);
always_ff @(posedge clk, posedge reset) begin
    if(reset) begin //reset == 1
        //reset system
        state <= 0;
        input_start <= 0;
        finish_getting_input <= 0;
        finish_getting_weight <= 0;
        finish_convolution_weight <= 0;
        finish_set_all_output <= 0;
        finish_save_output <= 0;
    end

    else begin
        //increase the state
        count <= count++;    
end

logic [2:0] state;

localparam IDLE = 0, GETTING_INPUT = 1, GETTING_WEIGHT = 2, CONVOLUTION_CALCULATION = 3, SET_PARTIAL_OUTPUT = 4,
    SAVE_OUTPUT = 5;;

always_comb begin
    case(state)

    IDLE: begin
        if(input_start) begin //input_start == 1
            state = GETTING_INPUT;
        end
        else begin//input_start != 1
            state = IDLE;
        end

    GETTING_INPUT: begin
        if(finish_getting_input) begin
            state = GETTING_WEIGHT;
        end
        else begin
            state = GETTING_INPUT;
        end

    GETTING_WEIGHT: begin
        if(finish_getting_weight) begin
            state = CONVOLUTION_CALCULATION;
        end
        else begin
            state = GETTING_WEIGHT;
        end

    CONVOLUTION_CALCULATION: begin
        if(finish_convolution_weight) begin
            state = SET_PARTIAL_OUTPUT;
        end
        else begin
            state = CONVOLUTION_CALCULATION;
        end

    SET_PARTIAL_OUTPUT: begin
        if(finish_set_all_output) begin
            state = SAVE_OUTPUT;
        end
        else begin
            state = SET_PARTIAL_OUTPUT;
        end

    SAVE_OUTPUT: begin
        if(finish_save_output) begin
            state = IDLE;
        end
        else begin
            state = SAVE_OUTPUT;
        end
    end
end
    
endmodule
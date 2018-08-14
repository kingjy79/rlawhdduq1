module d_filp_flop #(
    parameter INPUT_BW=16)(
    input logic input_clk, input_reset_negative,
    input logic signed [INPUT_BW-1:0] input1,
    output logic signed [INPUT_BW-1:0] output1
);

always_ff @(posedge input_clk, negedge input_reset_negative) begin
    if(~ input_reset_negative)begin
        output1 <= 0;
    end
    else begin
        output1 = input1;
    end
end
    
endmodule
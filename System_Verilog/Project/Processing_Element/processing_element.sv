module processing_element #(
    parameter INPUT_DATA_BW = 16, INPUT_WEIGHT_BW = 16, INPUT_PARTIAL_SUM_BW = 32, OUTPUT_PARTIAL_SUM_BW = 32)(
    input logic [INPUT_DATA_BW-1:0] input_data,
    input logic [INPUT_WEIGHT_BW-1:0] input_weight,
    input logic [INPUT_PARTIAL_SUM_BW-1:0] input_partial_sum,
    output logic [OUTPUT_PARTIAL_SUM_BW-1:0] output_partial_sum
);

localparam WIRE_MULTIPLIER_BW = 32;

logic [WIRE_MULTIPLIER_BW-1:0] wire_multiplier;

always_comb begin
    wire_multiplier = input_data * input_weight;
    output_partial_sum = wire_multiplier + input_partial_sum;
end
    
endmodule
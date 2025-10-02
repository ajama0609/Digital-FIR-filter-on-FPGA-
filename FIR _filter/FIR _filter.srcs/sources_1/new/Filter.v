module Multiply #(
    parameter TAP = 10,
    parameter DATA_WIDTH = 16,     
    parameter COEFF_WIDTH = 16,    
    parameter OUT_WIDTH = DATA_WIDTH + COEFF_WIDTH + $clog2(TAP)
)(
    input  wire clk,
    input  wire rst,
    input  wire [TAP*DATA_WIDTH-1:0]  data,
    input  wire [TAP*COEFF_WIDTH-1:0] coeffs,
    output reg  signed [OUT_WIDTH:0] out
);

    // Unpack flattened arrays
    wire signed [DATA_WIDTH-1:0]   data_arr   [0:TAP-1];
    wire signed [COEFF_WIDTH-1:0]  coeffs_arr [0:TAP-1];

    genvar i;
    generate
        for (i = 0; i < TAP; i = i + 1) begin
            assign data_arr[i]   = data[i*DATA_WIDTH +: DATA_WIDTH];
            assign coeffs_arr[i] = coeffs[i*COEFF_WIDTH +: COEFF_WIDTH];
        end
    endgenerate

    // MAC operation
    integer j;
    reg signed [OUT_WIDTH:0] acc; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            out <= 0;
        end else begin
            acc = 0;
            for (j = 0; j < TAP; j = j + 1) begin
                acc = acc + data_arr[j] * coeffs_arr[j]; // full precision
            end
            out <= acc;
        end
    end

endmodule

module Shift_register #(
    parameter TAP = 10,
    parameter DATA_WIDTH = 16
)(
    input  wire clk,
    input  wire rst,
    input  wire [DATA_WIDTH-1:0] samples_in,              
    output reg  [TAP*DATA_WIDTH-1:0] samples_out_flat     
);

    reg signed [DATA_WIDTH-1:0] stages [0:TAP-1];
    integer i;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < TAP; i = i + 1)
                stages[i] <= 0;
        end else begin
            for (i = TAP-1; i > 0; i = i - 1)
                stages[i] <= stages[i-1];
            stages[0] <= samples_in; 
        end
    end

    // Flatten stages: oldest sample first
    always @(*) begin
        for (i = 0; i < TAP; i = i + 1)
            samples_out_flat[i*DATA_WIDTH +: DATA_WIDTH] = stages[TAP-1-i];
    end

endmodule

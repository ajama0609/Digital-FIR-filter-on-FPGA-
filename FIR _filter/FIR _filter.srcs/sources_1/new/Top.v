module Top_FIR #(
    parameter TAP         = 10,
    parameter DATA_WIDTH  = 16,
    parameter COEFF_WIDTH = 16,
    parameter OUT_WIDTH = DATA_WIDTH + COEFF_WIDTH + $clog2(TAP)
)(  
    input  wire clk,
    input  wire rst,
    input  wire [DATA_WIDTH-1:0]  samples_in,
    output wire signed [OUT_WIDTH-1:0] out
); 

    reg signed [15:0] coeffs [0:TAP];

    // Shift register outputs
    wire [TAP*DATA_WIDTH-1:0]   samples_shifted_flat;
    wire [TAP*COEFF_WIDTH-1:0]  coeffs_shifted_flat; 
    
      
   initial $readmemh("coeffs.mem", coeffs);
        
        genvar i;
        // flatten array into bus
        generate
            for (i = 0; i < TAP; i = i + 1)
                assign coeffs_shifted_flat[i*COEFF_WIDTH +: COEFF_WIDTH] = coeffs[i];
        endgenerate 
        
    // Shift registers
    Shift_register #(
        .TAP(TAP),
        .DATA_WIDTH(DATA_WIDTH)
    ) sr_samples (
        .clk(clk),
        .rst(rst),
        .samples_in(samples_in),
        .samples_out_flat(samples_shifted_flat)
    );


    // Multiply-Accumulate
    Multiply #(
        .TAP(TAP),
        .DATA_WIDTH(DATA_WIDTH),
        .COEFF_WIDTH(COEFF_WIDTH),
        .OUT_WIDTH(OUT_WIDTH)
    ) mac (
        .clk(clk),
        .rst(rst),
        .data(samples_shifted_flat),
        .coeffs(coeffs_shifted_flat),
        .out(out)
    );

endmodule

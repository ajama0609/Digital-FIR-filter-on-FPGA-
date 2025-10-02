module tbFilter;

reg clk, rst; 
parameter TAP = 10;
reg signed [15:0] sample_in;
wire signed [35:0] out;

Top_FIR dut (
    .clk(clk),
    .rst(rst),
    .samples_in(sample_in),
    .out(out)
);

integer fd,r,i, f;
reg signed [15:0] samples [0:1000];


initial begin
    fd = $fopen("data.mem","r");
    i = 0;
    while (!$feof(fd)) begin
        r = $fscanf(fd, "%d\n", samples[i]);
        i = i + 1;
    end
    $fclose(fd);
end

initial clk = 0;
always #5 clk = ~clk;

initial begin
    rst = 1; @(posedge clk); rst = 0;

    f = $fopen("fir_output.txt", "w");

    for (i = 0; i < 1001; i = i + 1) begin
        sample_in = samples[i];
        @(posedge clk);
        if (i >= 9)  // TAP-1 = 10-1
            $fdisplay(f, "%0d", out);
    end

    $fclose(f);
    $finish;
end

endmodule

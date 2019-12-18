module shift_register(out, in, clk);
    output [3:0] out;
    input in;
    input clk;
    always @(posedge clk)
        out <= {in, out[n-1:1]};
endmodule
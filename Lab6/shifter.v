module shifter(out, in);
    output [31:0] out;
    input [31:0] in;
    assign out = {in[29:0], 2'b00};
endmodule


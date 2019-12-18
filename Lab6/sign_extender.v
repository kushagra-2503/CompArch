module sign_extender(out, in);
    output [31:0] out;
    input [15:0] in;

    assign out = {16{in[15]}, in[15:0]};
endmodule
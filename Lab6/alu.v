module mux2_1(out, sel, in0, in1);
    output out;
    input  in0, in1;
    input sel;
    wire n1, a1, a2;
    not(n1, sel);
    and(a1, in0, n1);
    and(a2, in1, sel);

    or(out, a1, a2);
endmodule


module bit32_mux2_1(out, sel, in0, in1);
    output [31:0] out;
    input [31:0] in0, in1;
    input sel;

    genvar j;

    generate for(j =0; j < 32; j = j+1) begin
        mux2_1 m1(out[j], sel, in0[j], in1[j]);
    end
    endgenerate
endmodule

module mux3_1(out, sel, in0, in1, in2);
    output out;
    input  in0, in1, in2;
    input [1:0]sel;
    wire n0, n1, a1, a2, a3;
    not(n0, sel[0]);
    not(n1, sel[1]);
    and(a1, in0, n0, n1);
    and(a2, in1, sel[0], n1);
    and(a3, in2, n0, sel[1]);
    or(out, a1, a2, a3);
endmodule


module bit32_mux3_1(out, sel, in0, in1, in2);
    output [31:0] out;
    input [31:0] in0, in1, in2;
    input [1:0]sel;

    genvar j;

    generate for(j =0; j < 32; j = j+1) begin: mux_loop
        mux3_1 m(out[j], sel, in0[j], in1[j], in2[j]);
    end
    endgenerate
endmodule

module bit32_and(out, in1, in2);
    output [31:0] out;
    input [31:0] in1, in2;
    assign {out} = in1 & in2;
endmodule

module bit32_or(out, in1, in2);
    output [31:0] out;
    input [31:0]in1, in2;
    assign out = in1 | in2;
endmodule

module bit32_FA(carry, out, a, b, cin);
    output [31:0] out;
    output carry;
    input [31:0] a, b;
    input cin;
    
    assign {carry, out} = a + b + cin;
endmodule

module alu(cout, result, binvert, a, b, op);
    output cout;
    output [31:0] result;
    input binvert;
    input [31:0] a, b;
    input [1:0] op;

    wire [31:0] w_b, w_and, w_or, w_add;
    bit32_mux2_1 m1(w_b, binvert, b, ~b);

    bit32_and m2(w_and, a, w_b);
    bit32_or m3(w_or, a, w_b);
    bit32_FA m4(cout, w_add, a, w_b, binvert);

    bit32_mux3_1 m5(result, op, w_and, w_or, w_add);
endmodule
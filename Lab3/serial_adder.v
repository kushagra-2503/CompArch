module shift_reg(en, in, clk, q);
    output [3:0] q;
    input in, clk, en;
    reg [3:0] q;
    always @(posedge clk)
        if(en)
            q = {in, q[n-1:1]};
endmodule


module fa(cout, s, a, b, cin);
    input a, b, cin;
    output s, cout;

    assign {s, cout} = a + b + cin;
endmodule

module d_ff(q, d, clk, reset);
    input d, clk, reset;
    output q;
    reg q;

    always @(posedge clk, posedge reset)
        if(reset)
         q = 0;
        else
            q = d;
endmodule

module serial_adder(output[3:0] serOut1, output sm, input serInp, input shiftCtrl, input clear, input clk);
    wire cin, cout, sm;
    wire [3:0] serOut1, serOut2;

    shift_reg a(shiftCtrl, sm, clk, serOut1);
    shift_reg b(shiftCtrl, serInp, clk, serOut2);

    fa mod(cout, serOut1[0], serOut2[0], cin);

    d_ff d(cin, cout, shiftCtrl & clk, reset);
endmodule

module testbench;
    wire sm;
    wire [3:0] serOut1;
    reg shiftCtrl, clear, serInp, clk;

    serial_adder mod(serOut1, sm, serInp, shiftCtrl, clear, clk);

    initial begin
    $monitor(, $time, " out = %d", serOut1);
    #0 clear = 1'b1; clk = 1'b0;
    #5 clear = 1'b0; serInp = 1'b1; shiftCtrl  = 1'b1;
    #25 $finish;
    end

    always 
    #5 clk = ~clk;
endmodule
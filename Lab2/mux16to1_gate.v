module mux4to1_gate(out, in , sel);
input [3:0] in;
input [1:0] sel;
output out;
wire a1, a2, a3, a4, n1, n2;

not (n1, sel[0]);
not (n2, sel[1]);

and (a1, in[0], n1, n2);
and (a2, in[1], sel[0], n2);
and (a3, in[2], sel[1], n1);
and (a4, in[3], sel[0], sel[1]);

or (out, a1, a2, a3, a4);
endmodule

module mux16to1_gate(out, in, select);
input [15:0] in;
input [3:0] select;
output out;
wire [3:0] w;

mux4to1_gate mux1(w[0], in[3:0], select[1:0]);
mux4to1_gate mux2(w[1], in[7:4], select[1:0]);
mux4to1_gate mux3(w[2], in[11:8], select[1:0]);
mux4to1_gate mux4(w[3], in[15:12], select[1:0]);
mux4to1_gate mux5(out, w[3:0], select[3:2]);

endmodule


module testbench_mux16;
  reg [15:0]in;
  reg [3:0]select;
  wire  out;
  mux16to1_gate mux(out, in, select);
  initial
    begin
      $monitor($time, " Input=%b, Select=%b, Output=%b.", in, select, out);
      #0  in = 16'b0000000000000100;  select = 4'b0000;
      repeat(15)
        begin
          #3  in = in<<1'b1;  select = select + 4'b0001;
        end
    end
endmodule


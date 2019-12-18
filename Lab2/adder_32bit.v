module decoder(d0, d1, d2, d3, d4, d5, d6, d7, x, y, z);
input x, y, z;
output d0, d1, d2, d3, d4, d5, d6, d7;
wire x0, y0, z0;
not (x0, x);
not (y0, y);
not (z0, z);
and (d0, x0, y0, z0);
and (d1, x0, y0, z);
and (d2, x0, y, z0);
and (d3, x0, y, z);
and (d4, x, y0, z0);
and (d5, x, y0, z);
and (d6, x, y, z0);
and (d7, x, y, z);
endmodule

module fadder(s, c, x, y, z);
input x, y, z;
output s, c;
wire d0, d1, d2, d3, d4, d5, d6, d7;
decoder d(d0, d1, d2, d3, d4, d5, d6, d7, x, y, z);
or (s,d1, d2, d4, d7);
or (c,d3, d5, d6, d7);
endmodule

module adder_8bit(s, c, x, y, z);
input [7:0] x, y;
input z;
output [7:0] s;
output c;
wire a0, a1, a2, a3, a4, a5, a6;
fadder adder1(s[0], a0, x[0], y[0], z);
fadder adder2(s[1], a1, x[1], y[1], a0);
fadder adder3(s[2], a2, x[2], y[2], a1);
fadder adder4(s[3], a3, x[3], y[3], a2);
fadder adder5(s[4], a4, x[4], y[4], a3);
fadder adder6(s[5], a5, x[5], y[5], a4);
fadder adder7(s[6], a6, x[6], y[6], a5);
fadder adder8(s[7], c, x[7], y[7], a6);
endmodule

module adder_32bit(s, c, x, y, z);
input [31:0] x, y;
input z;
output [31:0] s;
output c;
wire [2:0]a;
adder_8bit adder1(s[7:0],a[0], x[7:0], y[7:0], z);
adder_8bit adder2(s[15:8], a[1], x[15:8], y[15:8], a[0]);
adder_8bit adder3(s[23:16], a[2], x[23:16], y[23:16], a[1]);
adder_8bit adder4(s[31:24], c, x[31:24], y[31:24], a[2]);
endmodule

module testbench_32BFA;
  reg [31:0] A, B;
  reg CarryIn;
  wire  [31:0]Sum;
  wire  Carry;
  integer i, j;
  adder_32bit mod(Sum, Carry, A, B, CarryIn);
  initial
    begin
      $monitor($time," A = %b, B = %b, Carry In = %b, Carry = %b, Sum = %b.", A, B, CarryIn, Carry, Sum);
      #0 A=32'b11110000000000000000000000000000; B=32'b00000000000000000000000000000111; CarryIn=1'b0;
      #5 A=32'b11111111111111111111111111111111; B=32'b11111111111111111111111111111111; CarryIn=1'b0;
      #5 A=32'b11110000000000001111000000000000; B=32'b00001010101000000000000000000111; CarryIn=1'b1;
    end
endmodule



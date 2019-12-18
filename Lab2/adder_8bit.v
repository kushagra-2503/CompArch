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


module testbench_8BFA;
  reg [7:0] A, B;
  reg CarryIn;
  wire  [7:0]Sum;
  wire  Carry;
  integer i, j;
  adder_8bit mod(Sum, Carry, A, B, CarryIn);
  
  initial
    begin
      $monitor($time," A = %b, B = %b, Carry In = %b, Carry = %b, Sum = %b.", A, B, CarryIn, Carry, Sum);
      #0  A=8'b00000000;  B=8'b00000000;  CarryIn=1'b0;
      for(i=0; i<256; i=i+1)
        begin
          for(j=0; j<256; j=j+1)
            begin
              #3  CarryIn=1'b0;
              #3  CarryIn = CarryIn+1'b1;
              B=B+8'b00000001;
            end
            A=A+8'b00000001;
        end
    end
endmodule


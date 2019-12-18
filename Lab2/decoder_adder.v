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
wire [7:0] a;
decoder d(a[7], a[6], a[5], a[4], a[3], a[2], a[1], a[0], x, y, z);
or (s, a[6], a[5], a[3], a[0]);
or (c, a[0], a[1], a[2], a[4]);
endmodule


module testbench;
reg x, y, z;
wire s, c;
fadder f1(s, c, x, y, z);
initial
	$monitor (, $time, " x = %b, y = %b, z = %b, s = %b, c = %b", x, y, z, s, c);
		initial
			begin
			#0 x = 1'b0; y = 1'b0; z = 1'b0;
			#4 x = 1'b1; y = 1'b0; z = 1'b0;
			#4 x = 1'b0; y = 1'b1; z = 1'b0;
			#4 x = 1'b1; y = 1'b1; z = 1'b0;
			#4 x = 1'b0; y = 1'b0; z = 1'b1;
			#4 x = 1'b1; y = 1'b0; z = 1'b1;
			#4 x = 1'b0; y = 1'b1; z = 1'b1;
			#4 x = 1'b1; y = 1'b1; z = 1'b1;
			end
			
endmodule


 

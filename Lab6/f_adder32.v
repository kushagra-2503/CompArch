module f_adder32(carry, res, a, b, cin);
	input [31:0] a, b;
	input cin;
	output carry;
	output [31:0] res;
	assign {carry, res} = a + b + cin;
endmodule

module shift_left(out, in);
	input [31:0] in;
	output [31:0] out;
	assign out = {{in[29:0], 0}, 0};
endmodule

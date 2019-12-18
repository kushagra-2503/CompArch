module mux3to1(out, sel0, sel1, in1, in2, in3);
	input in1, in2, in3;
	input sel0, sel1;
	output out;
	
	wire n0, n1, a1, a2,a3;
	not(n0, sel0);
	not (n1, sel1);
	
	and (a1, n0, n1, in1);
	and (a2, sel0, n1, in2);
	and (a3, n0, sel1, in3);

	or (out, a1, a2, a3);
	
endmodule


module bit8_3to1mux_gen(out, sel0, sel1, in1, in2, in3);
	input [7:0] in1, in2, in3;
	output [7:0] out;
	input sel0, sel1;
	genvar j;
	generate for(j = 0; j < 8; j= j + 1) begin: mux_loop
		mux3to1 m1(out[j], sel0, sel1, in1[j], in2[j], in3[j]);
	end
	endgenerate
endmodule

module bit32_3to1mux_gen(out, sel0, sel1, in1, in2, in3);
	input [31:0] in1, in2, in3;
	output [31:0] out;
	input sel0, sel1;
	genvar j;
	
	generate for(j= 0 ; j < 32; j = j+8) begin: mux_loop
		bit8_3to1mux_gen m1(out[j+7 : j], sel0, sel1,  in1[j+7:j], in2[j+7:j], in3[j+7:j]);
	end
	endgenerate
endmodule

module tb_bit32mux3to1;
	reg [31:0] in1, in2, in3;
	wire [31:0] out;
	reg sel0, sel1;
	
	bit32_3to1mux_gen m1(out, sel0, sel1,in1, in2, in3);
	
	initial
	begin
	$monitor ($time, " In1 = %b, In2 = %b, In3 = %b, Sel0 = %b, Sel1 = %b, Out = %b", in1, in2, in3, sel0, sel1, out);
	in1 = 32'b10101010101010101010101010101010;
	in2 = 32'b01010101010101010101010101010101;
	in3 = 32'b11111111111111111111111111111111;
	
	sel0 = 0;
	sel1 = 0;
	
	#50 sel0 = 1; sel1 = 0;
	#50 sel0 = 0; sel1 = 1;
	
	#20 $finish;
	end
endmodule
	

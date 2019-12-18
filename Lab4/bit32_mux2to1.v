module mux2to1(out, sel, in1, in2);
	input in1, in2;
	input sel;
	output out;
	
	wire n, a1, a2;
	not(n, sel);
	
	and (a1, n, in1);
	and (a2, sel, in2);
	
	or (out, a1, a2);
	
endmodule

module bit8_2to1mux(out, sel, in1, in2);

	output [7:0] out;
	input [7:0] in1, in2;
	input sel;
	
	mux2to1 m1(out[0], sel, in1[0], in2[0]);
	mux2to1 m2(out[1], sel, in1[1], in2[1]);
	mux2to1 m3(out[2], sel, in1[2], in2[2]);
	mux2to1 m4(out[3], sel, in1[3], in2[3]);
	mux2to1 m5(out[4], sel, in1[4], in2[4]);
	mux2to1 m6(out[5], sel, in1[5], in2[5]);
	mux2to1 m7(out[6], sel, in1[6], in2[6]);
	mux2to1 m8(out[7], sel, in1[7], in2[7]);
	
endmodule

module bit8_2to1mux_gen(out, sel, in1, in2);
	input [7:0] in1, in2;
	output [7:0] out;
	input sel;
	genvar j;
	generate for(j = 0; j < 8; j= j + 1) begin: mux_loop
		mux2to1 m1(out[j], sel, in1[j], in2[j]);
	end
	endgenerate
endmodule

module bit32_2to1mux_gen(out, sel, in1, in2);
	input [31:0] in1, in2;
	output [31:0] out;
	input sel;
	genvar j;
	
	generate for(j= 0 ; j < 32; j = j+8) begin: mux_loop
		bit8_2to1mux_gen m1(out[j+7 : j], sel, in1[j+7:j], in2[j+7:j]);
	end
	endgenerate
endmodule


module tb_8bit2to1mux;
	reg [7:0] in1, in2;
	wire [7:0] out;
	reg sel;
	
	//bit8_2to1mux M1(out, sel, in1, in2);
	bit8_2to1mux_gen M1(out, sel, in1, in2);
	
	initial
	begin
		$monitor(,$time, " In1 = %b, In2 = %b, Sel = %b, Out = %b", in1, in2, sel, out);
		in1 = 8'b10101010;
		in2 = 8'b01010101;
		
		sel = 1'b0;
		
		#100 sel = 1'b1;
		#1000 $finish;
	end
endmodule

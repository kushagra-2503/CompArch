module d_ff(q, d, clk, reset);
	input d, clk, reset;
	output q;
	reg q;
	always @(posedge clk or negedge reset)
	begin
		if(!reset)
		begin
			q = 1'b0;
		end
		
		else
		begin
			q = d;
		end
	end
endmodule


module reg_32bit(q, d, clk, reset);
	input [31:0] d;
	input clk, reset;
	output [31:0] q;
	genvar j;
	
	generate for(j = 0; j < 32; j = j + 1) begin: d_loop
	d_ff ff(q[j], d[j], clk, reset);
	end
	endgenerate
endmodule

module tb_32bit;
	reg[31:0] d;
	reg clk, reset;
	wire [31:0] q;
	reg_32bit r(q, d, clk, reset);
	
	always @(clk)
		#5 clk <= ~clk;
	initial
	begin
		$monitor(, $time, "D = %b, Reset = %b, Q = %b", d, reset, q);
		#0 clk = 1'b1; reset = 1'b1; d = 32'hFFFFFFFF;
		#1 reset = 1'b0;
		#20 reset=  1'b1;
		#20 d = 32'hAFAFAFAF;
		#200 $finish;
	end
endmodule



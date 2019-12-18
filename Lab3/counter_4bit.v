module jk_ff(j, k, clk, q);
	input j, k, clk;
	output q;
	reg q;
	
	initial
		q = 1'b0;
	always @(posedge clk)
	begin
		if(j && k)
			q = ~q;
		else if(j)
			q = 1'b1;
		else if(k)
			q = 1'b0;
	end
endmodule

module counter(clk, Q);
	input  clk;
	output [3:0] Q;
	wire w0, w1;
	jk_ff ff1(1'b1, 1'b1, clk, Q[0]);
	jk_ff ff2(Q[0], Q[0], clk, Q[1]);
	and(w0, Q[0], Q[1]);
	jk_ff ff3(w0, w0, clk, Q[2]);
	and(w1, w0, Q[2]);
	jk_ff ff4(w1, w1, clk, Q[3]);
endmodule

module testbench;
	reg clk;
	wire [3:0] Q;
	
	counter c(clk, Q);
	
	initial 
		begin
			$monitor(, $time, " Output = %b", Q);
			clk = 1'b0;
			#165 $finish;
		end
	always
		#5 clk = ~clk;
endmodule	
	


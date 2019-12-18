module pc(count, clk, rst);
	input clk, rst;
	output [31:0]count;
	reg [31:0]count;
	always @(posedge clk)
		if(!rst)
			count = count + 1;
		else
			count = 0;
endmodule

module TBPC;
	reg clk, rst;
	wire [31:0]count;
	pc p(count, clk, rst);
	initial begin
		repeat(1000)
			#5 clk = ~clk;
	end
	
  initial begin
    $monitor($time, " Reset = %b, Count= %b.", rst, count);
    #0  clk = 1'b0; rst = 1'b1;
    #11  rst = 1'b0;
  end
endmodule
	

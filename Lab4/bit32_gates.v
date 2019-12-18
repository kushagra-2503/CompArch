module bit32_and(out, in1, in2);
	input [31:0] in1, in2;
	output [31:0] out;
	
	assign {out} = in1 & in2;
endmodule

module bit32_or(out, in1, in2);
	output [31:0] out;
	input [31:0] in1, in2;
	
	assign out = in1 | in2;
endmodule

module tb32bitand;
reg [31:0] IN1,IN2;
wire [31:0] OUT;
bit32_or a1 (OUT,IN1,IN2);
initial
begin
$monitor(, $time, " IN1 = %b, IN2 = %b, OUT = %b", IN1, IN2, OUT);
IN1=32'hA5A5;
IN2=32'h5A5A;
#100 IN1=32'h5A5A;
#400 $finish;
end
endmodule

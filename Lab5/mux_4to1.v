module mux4_1(regData, q1, q2, q3, q4, reg_no);
	output [31:0] regData;
	input [31:0] q1, q2, q3, q4;
	input [1:0] reg_no;
	reg [31:0] regData;
	
	always @(q1 or q2 or q3 or q4 or reg_no)
		case(reg_no)
		2'b00:regData = q1;
		2'b01:regData = q2;
		2'b10:regData = q3;
		2'b11:regData = q4;
		endcase
endmodule

module  tbMux4_1;
  reg [31:0]  Data0, Data1, Data2, Data3;
  reg [1:0] Select;
  wire  [31:0]  Out;
  mux4_1  m(Out, Data0, Data1, Data2, Data3, Select);
  initial begin
    $monitor($time, " Data0 = %b, Data1 = %b, Data2 = %b, Data3 = %b, Select = %b, Output = %b.", Data0, Data1, Data2, Data3, Select, Out);
    #0  Data0 = 32'hF0F0F0F0; Data1 = 32'hF8F8F8F8; Data2 = 32'hFBFBFBFB; Data3 = 32'hFFFFFFFF;
    #5  Select = 2'b00;
    #5  Select = 2'b01;
    #5  Select = 2'b10;
    #5  Select = 2'b11;
    #5  $finish;
  end
endmodule

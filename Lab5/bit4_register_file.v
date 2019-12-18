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

module decoder2_4(Out, In);
  input [1:0] In;
  output  [3:0] Out;
  assign  Out[0] = (~In[1] & ~In[0]),
          Out[1] = (~In[1] & In[0]),
          Out[2] = (In[1] & ~In[0]),
          Out[3] = (In[1] & In[0]);
endmodule

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


module bit4_register_file(clk, reset, read_reg1, read_reg2, write_data, write_reg, reg_write, read_data1, read_data2);
	input clk, reset, reg_write;
	input [1:0] read_reg1, read_reg2, write_reg;
	input [31:0] write_data;
	output [31:0] read_data1, read_data2;
	
	wire clk0, clk1, clk2, clk3;
	wire [31:0] q0, q1, q2, q3;
	wire [3:0] decoder_op;
	
	decoder2_4 d1(decoder_op, write_reg);
	
	and (clk0, clk, decoder_op[0], reg_write);
	and (clk1, clk, decoder_op[1], reg_write);
	and (clk2, clk, decoder_op[2], reg_write);
	and (clk3, clk, decoder_op[3], reg_write);
	
	reg_32bit r0(q0, write_data, clk0, reset);
	reg_32bit r1(q1, write_data, clk1, reset);
	reg_32bit r2(q2, write_data, clk2, reset);
	reg_32bit r3(q3, write_data, clk3, reset);
	
	mux4_1 m1(read_data1, q0, q1, q2, q3, read_reg1);
	mux4_1 m2(read_data2, q0, q1, q2, q3, read_reg2);
endmodule


module tb_register_file;
	reg clk, reset, reg_write;
	reg [1:0] read_reg1, read_reg2, write_reg;
	reg [31:0] write_data;
	wire [31:0] read_data1, read_data2;
	
	bit4_register_file rf(clk, reset, read_reg1, read_reg2, write_data, write_reg, reg_write, read_data1, read_data2);
	
	initial begin
		    $monitor($time, ": Reset = %b, RegWrite = %b, ReadReg1 = %b, ReadReg2 = %b, WriteRegNo = %b, WriteData = %b, ReadData1 = %b, ReadData2 = %b.", reset, reg_write, read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2);
		    #0 clk = 1'b1; read_reg1 = 2'b00; read_reg2 = 2'b01; reset = 1'b1;
		    #2 reset =  1'b0;
		    #10 reset = 1'b1; write_data = 32'hF0F0F0F0; reg_write = 1'b1; write_reg = 2'b00;
    		#10 reg_write = 1'b1;  write_data = 32'hF8F8F8F8; write_reg = 2'b01;
    		#10 reg_write = 1'b1;  write_data = 32'hFAFAFAFA; write_reg = 2'b10;
    		#10 reg_write = 1'b1;  write_data = 32'hFFFFFFFF; write_reg = 2'b11; 
    		#10 reg_write = 1'b0;
    		#10 read_reg1 = 2'b00; read_reg2 = 2'b01;
    		#10 read_reg1 = 2'b10; read_reg2 = 2'b11;
    		#10 $finish;
    	end
    	
    	always
    #5  clk = ~clk;
endmodule 
		     





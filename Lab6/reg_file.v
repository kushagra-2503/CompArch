module d_ff(q, d, clk, reset);
	output q;
	input d, clk, reset;
	reg q;
	always(@posedge clk)
		if(!reset)
			q = 1'b0
		else
			q = d;
endmodulereg


module bit32_reg(q, d, clk, reset);
	output [31:0] q;
	input [31:0] d;
	input clk, reset;
	genvar j;
	generate for(j = 0;j < 32; j= j + 1)
		d_ff d1(q[i], d[i], clk, reset);
	endgenerate
endmodule


module decoder5_32(out, in);
	output [31:0] out;
	input [4:0] in;
	
	 assign  Out[0] = (~In[4] & ~In[3] & ~In[2] & ~In[1] & ~In[0]),
          Out[1] = (~In[4] & ~In[3] & ~In[2] & ~In[1] & In[0]),
          Out[2] = (~In[4] & ~In[3] & ~In[2] & In[1] & ~In[0]),
          Out[3] = (~In[4] & ~In[3] & ~In[2] & In[1] & In[0]),
          Out[4] = (~In[4] & ~In[3] & In[2] & ~In[1] & ~In[0]),
          Out[5] = (~In[4] & ~In[3] & In[2] & ~In[1] & In[0]),
          Out[6] = (~In[4] & ~In[3] & In[2] & In[1] & ~In[0]),
          Out[7] = (~In[4] & ~In[3] & In[2] & In[1] & In[0]),
          Out[8] = (~In[4] & In[3] & ~In[2] & ~In[1] & ~In[0]),
          Out[9] = (~In[4] & In[3] & ~In[2] & ~In[1] & In[0]),
          Out[10] = (~In[4] & In[3] & ~In[2] & In[1] & ~In[0]),
          Out[11] = (~In[4] & In[3] & ~In[2] & In[1] & In[0]),
          Out[12] = (~In[4] & In[3] & In[2] & ~In[1] & ~In[0]),
          Out[13] = (~In[4] & In[3] & In[2] & ~In[1] & In[0]),
          Out[14] = (~In[4] & In[3] & In[2] & In[1] & ~In[0]),
          Out[15] = (~In[4] & In[3] & In[2] & In[1] & In[0]),
          Out[16] = (In[4] & ~In[3] & ~In[2] & ~In[1] & ~In[0]),
          Out[17] = (In[4] & ~In[3] & ~In[2] & ~In[1] & In[0]),
          Out[18] = (In[4] & ~In[3] & ~In[2] & In[1] & ~In[0]),
          Out[19] = (In[4] & ~In[3] & ~In[2] & In[1] & In[0]),
          Out[20] = (In[4] & ~In[3] & In[2] & ~In[1] & ~In[0]),
          Out[21] = (In[4] & ~In[3] & In[2] & ~In[1] & In[0]),
          Out[22] = (In[4] & ~In[3] & In[2] & In[1] & ~In[0]),
          Out[23] = (In[4] & ~In[3] & In[2] & In[1] & In[0]),
          Out[24] = (In[4] & In[3] & ~In[2] & ~In[1] & ~In[0]),
          Out[25] = (In[4] & In[3] & ~In[2] & ~In[1] & In[0]),
          Out[26] = (In[4] & In[3] & ~In[2] & In[1] & ~In[0]),
          Out[27] = (In[4] & In[3] & ~In[2] & In[1] & In[0]),
          Out[28] = (In[4] & In[3] & In[2] & ~In[1] & ~In[0]),
          Out[29] = (In[4] & In[3] & In[2] & ~In[1] & In[0]),
          Out[30] = (In[4] & In[3] & In[2] & In[1] & ~In[0]),
          Out[31] = (In[4] & In[3] & In[2] & In[1] & In[0]);
endmodule


module mux32_1(regData, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, sel);
	output [31:0] regData;
	reg [31:0] regData;
	input [31:0] q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31;
	input [4:0] sel;
	
	always @(q0 or q1 or q2 or q3 or q4 or q5 or q6 or q7 or q8 or q9 or q10 or q11 or q12 or q13 or q14 or q15 or q16 or q17 or q18 or q19 or q20 or q21 or q22 or q23 or q24 or q25 or q26 or q27 or q28 or q29 or q30 or q31 or sel);	
	
	case(select)
      5'b00000:  Out = Data00;
      5'b00001:  Out = Data01;
      5'b00010:  Out = Data02;
      5'b00011:  Out = Data03;
      5'b00100:  Out = Data04;
      5'b00101:  Out = Data05;
      5'b00110:  Out = Data06;
      5'b00111:  Out = Data07;
      5'b01000:  Out = Data08;
      5'b01001:  Out = Data09;
      5'b01010:  Out = Data10;
      5'b01011:  Out = Data11;
      5'b01100:  Out = Data12;
      5'b01101:  Out = Data13;
      5'b01110:  Out = Data14;
      5'b01111:  Out = Data15;
      5'b10000:  Out = Data16;
      5'b10001:  Out = Data17;
      5'b10010:  Out = Data18;
      5'b10011:  Out = Data19;
      5'b10100:  Out = Data20;
      5'b10101:  Out = Data21;
      5'b10110:  Out = Data22;
      5'b10111:  Out = Data23;
      5'b11000:  Out = Data24;
      5'b11001:  Out = Data25;
      5'b11010:  Out = Data26;
      5'b11011:  Out = Data27;
      5'b11100:  Out = Data28;
      5'b11101:  Out = Data29;
      5'b11110:  Out = Data30;
      5'b11111:  Out = Data31;
    endcase
 endmodule
 
 
module bit32_register_file(read_data1, read_data2, clock, reset, reg_write, read_reg1, read_reg2, write_reg, write_data);
	output [31:0] read_data1, read_data2;
	input clock, reset, reg_write;
	input [31:0] write_data;
	input [4:0] write_reg, read_reg1, read_reg2;
	wire [31:0]  q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31;
	wire [31:0] decoder_op;
	wire [31:0] c;
	genvar j;
	decoder5_32(decoder_op, write_reg);
	generate for(j = 0; j < 32; j = j + 1)
		and(c[j], decoder_op[j], clock, reg_write);
	endgenerate
	bit32_reg r0(q0, write_data, c[0], reset);
	bit32_reg r1(q1, write_data, c[1], reset);
	bit32_reg r2(q2, write_data, c[2], reset);
	bit32_reg r3(q3, write_data, c[3], reset);
	bit32_reg r4(q4, write_data, c[4], reset);
	bit32_reg r5(q5, write_data, c[5], reset);
	bit32_reg r6(q6, write_data, c[6], reset);
	bit32_reg r7(q7, write_data, c[7], reset);
	bit32_reg r8(q8, write_data, c[8], reset);
	bit32_reg r9(q9, write_data, c[9], reset);
	
	bit32_reg r10(q10, write_data, c[10], reset);
	bit32_reg r11(q11, write_data, c[11], reset);
	bit32_reg r12(q12, write_data, c[12], reset);
	bit32_reg r13(q13, write_data, c[13], reset);
	
	bit32_reg r14(q14, write_data, c[14], reset);
	bit32_reg r15(q15, write_data, c[15], reset);
	bit32_reg r16(q16, write_data, c[16], reset);
	bit32_reg r17(q17, write_data, c[17], reset);
	bit32_reg r18(q18, write_data, c[18], reset);
	bit32_reg r19(q19, write_data, c[19], reset);
	bit32_reg r20(q20, write_data, c[20], reset);
	
	bit32_reg r21(q21, write_data, c[21], reset);
	bit32_reg r22(q22, write_data, c[22], reset);
	bit32_reg r23(q23, write_data, c[23], reset);
	bit32_reg r24(q24, write_data, c[24], reset);
	bit32_reg r25(q25, write_data, c[25], reset);
	bit32_reg r26(q26, write_data, c[26], reset);
	bit32_reg r27(q27, write_data, c[27], reset);
	bit32_reg r28(q28, write_data, c[28], reset);
	bit32_reg r29(q29, write_data, c[29], reset);
	bit32_reg r30(q30, write_data, c[30], reset);
	bit32_reg r31(q31, write_data, c[31], reset);
	
	mux32_1 m1(read_data1, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, read_reg1);
	mux32_1 m1(read_data2, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, read_reg2);
endmodule
	
	 
		

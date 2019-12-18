module d_ff(q, d, clk, reset);
    output q;
    input d, clk, reset;
    reg q;
    always @(posedge clk or negedge reset)
        if(!reset)
            q = 1'b0;
        else
            q = d;
endmodule

module reg_32bit(q, d, clk, reset);
    output [31:0] q;
    input [31:0] d;
    input clk, reset;

    genvar j;

    generate for(j = 0; j < 32; j = j + 1) begin
       d_ff d1(q[j], d[j], clk, reset); 
    end
    endgenerate
endmodule


module mux32_1(regData, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, sel);
    output [31:0] regData;
    input[31:0] q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31;
    input [4:0] sel;
    reg[31:0] regData;

    always @(q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, sel)
    begin
        case(sel)
        5'b00000: regData = q0;
        5'b00001: regData = q1;
        5'b00010: regData = q2;
        5'b00011: regData = q3;
        5'b00100: regData = q4;
        5'b00101: regData = q5;
        5'b00110: regData = q6;
        5'b00111: regData = q7;
        5'b01000: regData = q8;
        5'b01001: regData = q9;
        5'b01010: regData = q10;
        5'b01011: regData = q11;
        5'b01100: regData = q12;
        5'b01101: regData = q13;
        5'b01110: regData = q14;
        5'b01111: regData = q15;
        5'b10000: regData = q16;
        5'b10001: regData = q17;
        5'b10010: regData = q18;
        5'b10011: regData = q19;
        5'b10100: regData = q20;
        5'b10101: regData = q21;
        5'b10110: regData = q22;
        5'b10111: regData = q23;
        5'b11000: regData = q24;
        5'b11001: regData = q25;
        5'b11010: regData = q26;
        5'b11011: regData = q27;
        5'b11100: regData = q28;
        5'b11101: regData = q29;
        5'b11110: regData = q30;
        5'b11111: regData = q31;
        endcase
    end
endmodule


module decoder5_32(register, reg_no);
    output [31:0] register;
    input [4:0] reg_no;
    reg[31:0] register;

    always@(reg_no)
    begin 
        case(reg_no)
        5'b00000: register = 32'h00000001;
        5'b00001: register = 32'h00000002;
        5'b00010: register = 32'h00000004;
        5'b00011: register = 32'h00000008;
        5'b00100: register = 32'h00000010;
        5'b00101: register = 32'h00000020;
        5'b00110: register = 32'h00000040;
        5'b00111: register = 32'h00000080;
        5'b01000: register = 32'h00000100;
        5'b01001: register = 32'h00000200;
        5'b01010: register = 32'h00000400;
        5'b01011: register = 32'h00000800;
        5'b01100: register = 32'h00001000;
        5'b01101: register = 32'h00002000;
        5'b01110: register = 32'h00004000;
        5'b01111: register = 32'h00008000;
        5'b10000: register = 32'h00010000;
        5'b10001: register = 32'h00020000;
        5'b10010: register = 32'h00040000;
        5'b10011: register = 32'h00080000;
        5'b10100: register = 32'h00100010;
        5'b10101: register = 32'h00200000;
        5'b10110: register = 32'h00400000;
        5'b10111: register = 32'h00800000;
        5'b11000: register = 32'h01000000;
        5'b11001: register = 32'h02000000;
        5'b11010: register = 32'h04000000;
        5'b11011: register = 32'h08000000;
        5'b11100: register = 32'h10000000;
        5'b11101: register = 32'h20000000;
        5'b11110: register = 32'h40000000;
        5'b11111: register = 32'h80000000;
        endcase
    end
endmodule

module reg_file(clk, reset, ReadReg1, ReadReg2, WriteData, WriteReg, RegWrite, ReadData1, ReadData2);
    input clk, reset, RegWrite;
    input [4:0] ReadReg1, ReadReg2, WriteReg;
    input [31:0] WriteData;
    output [31:0] ReadData1, ReadData2; 
    wire [31:0] decoder_out;
    wire [31:0] reg_clk;
    genvar j;
    decoder5_32 mod1(decoder_out, WriteReg);
    wire [31:0] q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31;
    generate for(j =0; j< 32; j=  j+1) begin
        and(reg_clk[j], clk, RegWrite, decoder_out[j]);
    end
    endgenerate

    reg_32bit r0(q0, WriteData, reg_clk[0], reset);
    reg_32bit r1(q1, WriteData, reg_clk[1], reset);
    reg_32bit r2(q2, WriteData, reg_clk[2], reset);
    reg_32bit r3(q3, WriteData, reg_clk[3], reset);
    reg_32bit r4(q4, WriteData, reg_clk[3], reset);
    reg_32bit r5(q5, WriteData, reg_clk[3], reset);
    reg_32bit r6(q6, WriteData, reg_clk[3], reset);
    reg_32bit r7(q7, WriteData, reg_clk[3], reset);
    reg_32bit r8(q8, WriteData, reg_clk[3], reset);
    reg_32bit r9(q9, WriteData, reg_clk[3], reset);
    reg_32bit r10(q10, WriteData, reg_clk[3], reset);
    reg_32bit r11(q11, WriteData, reg_clk[3], reset);
    reg_32bit r12(q12, WriteData, reg_clk[3], reset);
    reg_32bit r13(q13, WriteData, reg_clk[3], reset);
    reg_32bit r14(q14, WriteData, reg_clk[3], reset);
    reg_32bit r15(q15, WriteData, reg_clk[3], reset);
    reg_32bit r16(q16, WriteData, reg_clk[3], reset);
    reg_32bit r17(q17, WriteData, reg_clk[3], reset);
    reg_32bit r18(q18, WriteData, reg_clk[3], reset);
    reg_32bit r19(q19, WriteData, reg_clk[3], reset);
    reg_32bit r20(q20, WriteData, reg_clk[3], reset);
    reg_32bit r21(q21, WriteData, reg_clk[3], reset);
    reg_32bit r22(q22, WriteData, reg_clk[3], reset);
    reg_32bit r23(q23, WriteData, reg_clk[3], reset);
    reg_32bit r24(q24, WriteData, reg_clk[3], reset);
    reg_32bit r25(q25, WriteData, reg_clk[3], reset);
    reg_32bit r26(q26, WriteData, reg_clk[3], reset);
    reg_32bit r27(q27, WriteData, reg_clk[3], reset);
    reg_32bit r28(q28, WriteData, reg_clk[3], reset);
    reg_32bit r29(q29, WriteData, reg_clk[3], reset);
    reg_32bit r30(q30, WriteData, reg_clk[3], reset);
    reg_32bit r31(q31, WriteData, reg_clk[3], reset);
    
    mux32_1 mux1(ReadData1, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, ReadReg1);
    mux32_1 mux2(ReadData2, q0, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, ReadReg2);
endmodule


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



module mux4_1(regData, q1, q2, q3, q4, reg_no);
    output [31:0]   regData;
    input [31:0] q1, q2, q3, q4;
    input [1:0] reg_no;
    reg[31:0] regData;

    always @(q1 or q2 or q3 or q4 or reg_no)    
    begin
        case(reg_no)
        2'b00: regData = q1;
        2'b01: regData = q2;
        2'b10: regData = q3;
        2'b11: regData = q4;
        endcase
    end
endmodule


module decoder2_4(register, reg_no);
    output [3:0] register;
    input [1:0] reg_no;
    reg[3:0] register;

    always@(reg_no)
    begin 
        case(reg_no)
        2'b00: register = 4'h1;
        2'b01: register = 4'h2;
        2'b10: register = 4'h4;
        2'b11: register = 4'h8;
        endcase
    end
endmodule

// module decoder2_4(register, reg_no);
//     output [3:0] register;
//     input [1:0] reg_no;

//     assign register[3] = reg_no[0] & reg_no[1], 
//     register[2] = reg_no[1] & ~reg_no[0], 
//     register[1] = ~reg_no[1] & reg_no[0], 
//     register[0] = ~reg_no[0] & ~reg_no[1];
// endmodule


module reg_file(clk, reset, ReadReg1, ReadReg2, WriteData, WriteReg, RegWrite, ReadData1, ReadData2);
    input clk, reset, RegWrite;
    input [1:0] ReadReg1, ReadReg2, WriteReg;
    input [31:0] WriteData;
    output [31:0] ReadData1, ReadData2; 
    wire [3:0] decoder_out;
    wire [3:0] reg_clk;
    genvar j;
    decoder2_4 mod1(decoder_out, WriteReg);
    wire [31:0] q0,q1, q2, q3;
    generate for(j =0; j< 4; j=  j+1) begin
        and(reg_clk[j], clk, RegWrite, decoder_out[j]);
    end
    endgenerate

    reg_32bit r0(q0, WriteData, reg_clk[0], reset);
    reg_32bit r1(q1, WriteData, reg_clk[1], reset);
    reg_32bit r2(q2, WriteData, reg_clk[2], reset);
    reg_32bit r3(q3, WriteData, reg_clk[3], reset);
    
    mux4_1 mux1(ReadData1, q0, q1, q2, q3, ReadReg1);
    mux4_1 mux2(ReadData2, q0, q1, q2, q3, ReadReg2);
endmodule



module tbRegFile4;
  reg Clock, Reset, RegWrite;
  reg [1:0] ReadReg1, ReadReg2, WriteRegNo;
  reg [31:0]  WriteData;
  wire  [31:0]  ReadData1, ReadData2;
  reg_file rgf(Clock, Reset, ReadReg1, ReadReg2, WriteData, WriteRegNo, RegWrite, ReadData1, ReadData2);
  initial begin
    $monitor($time, ": Reset = %b, RegWrite = %b, ReadReg1 = %b, ReadReg2 = %b, WriteRegNo = %b, WriteData = %b, ReadData1 = %b, ReadData2 = %b.", Reset, RegWrite, ReadReg1, ReadReg2, WriteRegNo, WriteData, ReadData1, ReadData2);
    #0  Clock = 1'b1; ReadReg1 = 2'b00; ReadReg2 = 2'b01; Reset = 1'b1;
    #2  Reset = 1'b0;
    #10 Reset = 1'b1; RegWrite = 1'b1;  WriteData = 32'hF0F0F0F0; WriteRegNo = 2'b00;
    #10 RegWrite = 1'b1;  WriteData = 32'hF8F8F8F8; WriteRegNo = 2'b01;
    #10 RegWrite = 1'b1;  WriteData = 32'hFAFAFAFA; WriteRegNo = 2'b10;
    #10 RegWrite = 1'b1;  WriteData = 32'hFFFFFFFF; WriteRegNo = 2'b11;
    #10 RegWrite = 1'b0;
    #10 ReadReg1 = 2'b00; ReadReg2 = 2'b01;
    #10 ReadReg1 = 2'b10; ReadReg2 = 2'b11;
    #10 $finish;
  end
  always
    #5  Clock = ~Clock;
endmodule



// module tb_mux;
//     wire[31:0] regData;
//     reg [31:0] q1, q2, q3, q4;
//     reg[1:0] reg_no;

//     mux4_1 m(regData, q1, q2, q3, q4, reg_no);

//     initial begin
//         $monitor(, $time, " q1 = %b, q2 = %b, q3 = %b, q4 = %b, regData = %b, reg_no = %b", q1, q2, q3, q4, regData, reg_no);
//         #5 q1 = 32'hFFFFFFFF; q2 = 32'h00000000; q3 = 32'h00000000; q4 = 32'h00000000; reg_no = 2'b00;
//         #5 q2 = 32'hFFFFFFFF; q1 = 32'h00000000; q3 = 32'h00000000; q4 = 32'h00000000; reg_no = 2'b01;
//         #5 q3 = 32'hFFFFFFFF; q2 = 32'h00000000; q1 = 32'h00000000; q4 = 32'h00000000; reg_no = 2'b10;
//         #5 q4 = 32'hFFFFFFFF; q2 = 32'h00000000; q3 = 32'h00000000; q1 = 32'h00000000; reg_no = 2'b11;
//     end
// endmodule

// module tb32reg;
//     wire [31:0] q;
//     reg [31:0] d;
//     reg clk, reset;

//     reg_32bit r(q, d, clk, reset);

//     always begin
//     #2 clk = ~clk;
//     end

//     initial begin
//         $monitor(, $time, " d = %b, q = %b, reset = %b", d, q, reset);
//         clk = 1'b0;
//         reset = 1'b0;
//         d = 32'h0000;
//         #1 reset = 1'b1;
//          d = 32'h0001;
//         #5 d = 32'h0010;
//         #5 d = 32'hffffffff;
//         #5 $finish;
//     end
// endmodule
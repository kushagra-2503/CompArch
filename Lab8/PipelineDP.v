module encoder(OpCode, FuncCode);
    input [7:0] FuncCode;
    output [2: 0] OpCode;
    reg [2: 0] OpCode;

    always @(FuncCode) begin
    case (FuncCode)
        8'h80: OpCode = 3'b000;
        8'h40: OpCode = 3'b001;
        8'h20: OpCode = 3'b010;
        8'h10: OpCode = 3'b011;
        8'h08: OpCode = 3'b100;
        8'h04: OpCode = 3'b101;
        8'h02: OpCode = 3'b110;
        8'h01: OpCode = 3'b111;
    endcase
    end
endmodule


module ALU(Carry, X, A, B, OpCode);
    output [3:0] X;
    output Carry;
    reg [3:0] X;
    reg Carry;
    input [3:0] A, B;
    input [2: 0] OpCode;

    always @(A, B, OpCode) begin
        case(OpCode)
        3'b000: {Carry, X} = A + B;
        3'b001: {Carry, X} = A - B;
        3'b010: X = A ^ B;
        3'b011: X = A | B;
        3'b100: X = A & B;
        3'b101: X = ~(A | B);
        3'b110: X = ~(A & B);
        3'b111: X = ~(A ^ B);
    endcase
    end
endmodule

module ParityGenerator(Out, X);
    output Out;
    input [3:0] X;
    assign Out = ~(X[0] ^ X[1] ^ X[2] ^ X[3]);
endmodule

module FIRSTPIPE(clk, opcode, A, B, OpOut, AOut, Bout);
    output [2:0] OpOut;
    output [3:0] AOut, Bout;
    reg [2:0] OpOut;
    reg [3:0] AOut, Bout;
    input clk;
    input [2:0] opcode;
    input [3:0] A, B;
    always @(posedge clk) begin
        AOut <= A;
        Bout <= B;
        OpOut <= opcode;
    end
endmodule


module SECONDPIPE(clk, ALURes, Xout);
    output  [3:0] Xout;
    reg [3:0] Xout;
    input [3:0] ALURes;
    input clk;
    always @(posedge clk) begin
        Xout = ALURes;
    end
endmodule


module DATAPATH(clk, FuncCode, A, B, out);
    input clk;
    input [7:0] FuncCode;
    input [3:0] A, B;
    output out;
    wire  [2:0] opcode, OpOut;
    wire [3:0] AOut;
    wire [3:0] BOut;
    wire [3:0] Xout;
    wire [3:0] X;
    wire carry;

    encoder mod1(opcode, FuncCode);
    FIRSTPIPE mod2(clk, opcode, A, B, OpOut, AOut, BOut);
    ALU mod3(carry, X, AOut, BOut, OpOut);
    SECONDPIPE mod4(clk, X, Xout);
    ParityGenerator mod5(out, Xout);
endmodule

module TESTBENCH;
  reg clock;
  reg [7:0] FuncCode;
  reg [3:0] A, B;
  wire  Out;
  DATAPATH  mod(clock, FuncCode, A, B, Out);
  initial begin
    $monitor($time, " A = %b, B = %b, Function Code = %b, OpCode = %b, AOut = %b, BOut = %b, OpOut = %b, X = %b, Carry = %b, XOut = %b, Output = %b.", A, B, FuncCode, mod.opcode, mod.AOut, mod.BOut, mod.OpOut, mod.X, mod.carry, mod.Xout, Out);
    #0  clock = 1'b1;
    #4  A = 4'b0101; B = 4'b1110;  FuncCode = 8'b10000000;
    #20 FuncCode = 8'b01000000;
    #20 FuncCode = 8'b00100000;
    #20 FuncCode = 8'b00010000;
    #20 FuncCode = 8'b00001000;
    #20 FuncCode = 8'b00000100;
    #20 FuncCode = 8'b00000010;
    #20 FuncCode = 8'b00000001;
    #50 $finish;
  end
  always
    #2  clock = ~clock;
endmodule
module alu_control(op, f, aluop0, aluop1);
    output [2:0] op;
    input [5:0] f;
    input aluop0, aluop1;

    assign op[2] = aluop0 | (aluop1 & f[1]);
    assign op[1] = ~(aluop1 &  f[2]);
    assign op[0] = aluop1 & (f[3] | f[0]);
endmodule


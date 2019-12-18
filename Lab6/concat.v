
module concatJuPC(out, J, PC);
  input [31:0] J, PC;
  output [31:0] out;
  assign {out} = {{PC[31:28]}, {J[27:0]}};
endmodule

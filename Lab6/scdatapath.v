module d_ff(q, d, clk, reset);
    input d;
    input clk, reset;
    output q;
    reg q;
     always@(posedge clk, negedge reset)
        if(!reset)
            q = 0;
        else
            q = d;
endmodule


module reg_5bit(q, d, clk, reset);
    input [4:0] d;
    input clk, reset;
    output [4:0] q;

    genvar j;

    generate for(j = 0 ; j < 5; j =  j+1)
        d_ff d(q[j], d[j], clk, reset);
    endgenerate
endmodule

module  alu(Zero, CarryOut, Result, A, B, Op);
  input [2:0] Op;
  input [31:0] A, B;
  output [31:0] Result;
  reg [31:0] Result;
  output CarryOut, Zero;
  reg CarryOut;
  assign Zero = (({Result} == 0)) ? 1 : 0;
  always @ (Op, A, B) begin
    case(Op)
      0:  Result <= A & B;
      1:  Result <= A | B;
      2:  {CarryOut, Result[31:0]} <= A + B;
      6:  {CarryOut, Result[31:0]} <= A - B;
      7:  Result <= A < B ? 1 : 0;
      default: Result <= 0;
    endcase
  end
endmodule


module sc_datapath(alu_out, reset, clk);
    output [31:0]alu_out;
    input reset, clk;
    wire [4:0] pc_out, pc;

    reg_5bit mod1(pc, pc_out, reset, clk);

    initial
    pc_out = 5'b00000;

    wire [31:0] ins;
    ins_mem mod2(ins, pc, reset);

    wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, aluop1, aluop2;
    main_control mod3(reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, aluop1, aluop2, ins[[31:26]]);

    wire [31:0] reg_data1, reg_data2, write_data;

    register_file mod3(clk, reset, ins[26:21], ins[20:16], write_data, ins[16:11], 1'b0, reg_data1, reg_data2);
    
    wire[2:0] op;
    alu_control mod4(op, ins[5:0], aluop1, aluop2);
    wire zero, cout;
    wire [31:0] res;
    alu mod5(zero, cout, res, reg_data1, reg_data2);
    assign alu_out = res;
    register_file mod6(clk, reset, ins[26:21], ins[20:16], res, ins[16:11], 1;b1, reg_data1, reg_data2);
    wire c;
    bit32_FA mod7(c, pc_out, pc, 32'h00000001, 1'b0);
endmodule
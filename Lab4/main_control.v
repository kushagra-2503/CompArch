module main_control(reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, aluop1, aluop2, op);
    output reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, aluop1, aluop2;
    input [5:0] op;
    wire r_format, lw, sw, beq;
    
    assign r_format = (~op[5]) & ~op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];
    assign lw = (op[5]) & ~op[4] & ~op[3] & ~op[2] & op[1] & op[0];
    assign sw = (op[5]) & ~op[4] & op[3] & ~op[2] & op[1] & op[0];
    assign beq = (~op[5]) & ~op[4] & ~op[3] & op[2] & ~op[1] & ~op[0];

    assign reg_dst = r_format;
    assign alu_src = lw | sw;
    assign mem_to_reg = lw;
    assign reg_write = lw | r_format;
    assign mem_read = lw;
    assign mem_write = sw;
    assign branch = beq;
    assign aluop1 = r_format;
    assign aluop2 = beq;
endmodule
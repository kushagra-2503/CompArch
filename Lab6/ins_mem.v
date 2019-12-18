module ins_mem(instr, pc, reset);
    output [31:0] instr;
    input [4:0] pc;
    input reset;
    reg [31:0] mem[0:31];
    genvar j;
    generate for(j = 0; j < 32; j = j + 1)
        mem[j] = 32'h00000000;
    endgenerate

    always @(pc or reset)
        if(reset)
        begin
           mem[0] = 32'h00000200;
           mem[1] = 32'h00000201;
           mem[2] = 32'h00000204;
           mem[3] = 32'h00000108; 
        end

        else
        begin
            instr = mem[pc];
        end
endmodule



module data_mem(mem_read,mem_write, WriteData, addr, clk, ReadData);
    input mem_read, mem_write, clk;
    input [31:0] WriteData;
    input [4:0] addr;
    output [31:0] ReadData;
    
    reg[31:0] mem[0:31];
    genvar j;
    generate for(j = 0; j < 32; j=  j + 1)
        mem[j] = 32'h00000000;
    endgenerate

    always @(posedge clk) begin
        if(mem_write)
        mem[addr] = WriteData;

        if(mem_read)
        ReadData = mem[addr];
     
    end
endmodule
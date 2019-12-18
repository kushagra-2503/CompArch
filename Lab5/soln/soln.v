module d_ff(q, d, clk, reset);
    input d, clk, reset;
    output q;
    reg q;

    always@(posedge clk, negedge reset)
        if(!reset)
            q <= 1'b0;
        else
            q <= d;
endmodule


module reg_32bit(q, d, clk, reset);
    input [31:0] d;
    input clk , reset;
    output [31:0] q;

    genvar j;
    generate for(j = 0; j < 32; j = j +1) begin
        d_ff d(q[j], d[j], clk, reset);
    endgenerate
endmodule


module mux4_1(regData, q1, q2, q3, q4, reg_no);
    input [31:0] q1, q2, q3, q4;
    input [1:0] reg_no;
    output [31:0] regData;
    reg[31:0] regData;
    always @(q1, q2, q3, q4, reg_no)
        case(reg_no)
        2'b00: regData = q1;
        2'b01: regData = q2;
        2'b10: regData = q3;
        2'b11: regData = q4;
        endcase
endmodule


module decoder2_4(register, reg_no);
    input [1:0] reg_no;
    output [3:0] register;
    reg [3:0] register;

    always @(reg_no)
        case(reg_no)
        2'b00: register = 4'b1;
        2'b01: register = 4'b2;
        2'b10: register = 4'b4;
        2'b11: register = 4'b8;
        endcase
endmodule


module reg_file(clk, reset, read_reg1, read_reg2, write_data, write_reg, reg_write, read_data1, read_data2);
    input clk, reset, reg_write;
    input [31:0] write_data;
    input [4:0] read_reg1, read_reg2, write_reg;
    output [31:0] read_data1, read_data2;
    wire [3:0] decoder_out;
    decoder2_4 mod1(decoder_out, write_reg);
    wire [31:0] q1, q2, q3, q4;
    wire clock0, clock1, clock2, clock3;
    assign clock0 = clk & decoder_out[0] & reg_write, 
            clock1 = clk & decoder_out[1] & reg_write, 
            clock2 = clk & decoder_out[2] & reg_write, 
            clock3 = clk & decoder_out[3] & reg_write;

    reg_32bit mod2(q1, write_data, clk0, reset);
    reg_32bit mod3(q2, write_data, clk1, reset);
    reg_32bit mod4(q3, write_data, clk2, reset);
    reg_32bit mod5(q4, write_data, clk3, reset);

    mux4_1 mod6(read_data1, q1, q2, q3, q4, read_reg1);
    mux4_1 mod7(read_data2, q1, q2, q3, q4, read_reg2);
endmodule
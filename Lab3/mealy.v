module mealy(clk, reset, inp, outp);
    input clk, reset, inp;
    output outp;
    reg [1:0] state;
    reg outp;
    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            state = 2'b00;
            outp = 0;
        end
        else
        begin
            case(state)
            2'b00: begin 
            if(inp)
            begin
                state <= 2'b01;
                outp <= 0;
            end
            else  begin  
                state <= 2'b10;
                outp <= 0;
            end
            end
            2'b01: begin
            if(inp)
            begin
                state <= 2'b10;
                outp <= 1;
            end
            else
            begin
                state <= 2;
                outp <= 0;
            end
            end

            2'b10: begin
            if(inp)
            begin
                state <= 2'b01;
                outp <= 0;
            end    
            else    
            begin
                state <= 2'b00;
                outp <= 1;
            end
            end
            endcase
        end

    end
endmodule


module tesetbench;
    wire outp;
    reg clk, reset, inp;

    mealy mod(clk, reset, inp, outp);

    initial begin
        $monitor(, $time, " inp = %b, outp = %b, state = %b", inp, outp, mod.state);
        #0 clk = 1'b0; reset = 1'b1;
        #5 reset = 1'b0; inp = 1;
        #5 inp = 0;
        #5 inp = 1;
        #200 $finish;
    end

    always
    #5 clk = ~clk;
endmodule
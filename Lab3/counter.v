module jk_ff(j, k, clk, q);
    input j, k, clk;
    output q;
    reg q;
    
    initial 
        q = 1'b0;   
    always @(posedge clk)
        begin
            if(j && k)
                q = ~q;
            else if(j)
                q = 1;
            else if(k)
                q = 0;
        end
endmodule


module counter(q, clk);
    output [3:0] q;
    input clk;
    wire q0q1, q0q1q2;
    jk_ff f1(1'b1, 1'b1, clk,  q[0]);
    //assign q0 = q[0];
    jk_ff f2(q[0], q[0], clk,  q[1]);

    and (q0q1, q[0], q[1]);
    jk_ff f3(q0q1, q0q1, clk, q[2]);

    and(q0q1q2, q0q1, q[2]);
    jk_ff f4(q0qq1q2, q0q1q2, clk,  q[3]);

endmodule

module testbench;
    reg clk;
    wire [3:0] q;

    counter mod(q, clk);

    initial begin
       $monitor(, $time, " q = %b", q);
       clk = 1'b0;
       #165 $finish; 
    end

    always begin
        #5 clk = ~clk;
    end
endmodule
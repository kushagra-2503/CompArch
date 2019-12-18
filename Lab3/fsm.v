module fsm(in, reset, clk, q);
	input in, clk, reset;
	output q;
	reg q;
	reg [2:0] state;
	
	initial
	begin
		state = 3'b000;
		q = 1'b0;
	end
	
	always @(posedge clk)
		begin
			if(reset)
				begin
					state = 3'b000;
					q = 1'b0;
				end
			else
				begin
					case(state)
						3'b000:
							begin
								if(in)
									begin
										state  = 3'b001;
										q = 1'b0;
									end
								else
									begin
										state = 3'b000;
										q = 1'b0;
									end
							end
						3'b001:
							begin
								if(in)
									begin
										state  = 3'b010;
										q = 1'b0;
									end
								else
									begin
										state = 3'b000;
										q = 1'b0;
									end
							end
						3'b010:
							begin
								if(in)
									begin
										state  = 3'b011;
										q = 1'b0;
									end
								else
									begin
										state = 3'b000;
										q = 1'b0;
									end
							end
						3'b011:
							begin
								if(in)
									begin
										state  = 3'b100;
										q = 1'b0;
									end
								else
									begin
										state = 3'b010;
										q = 1'b0;
									end
							end
						3'b100:
							begin
								if(in)
									begin
										state  = 3'b001;
										q = 1'b0;
									end
								else
									begin
										state = 3'b010;
										q = 1'b1;
									end
							end
						endcase
					end
				end
endmodule


module testbench;
	reg clk, rst, in;
	wire out;
	
	reg[15:0] sequence;
	integer i;
	
	fsm mod(in, rst, clk, out);
	
	initial
	begin
		#0 clk = 1'b0; rst = 1'b1; sequence = 16'b0101101101110010;
		#5 rst = 1'b0;
		for(i= 0 ; i <= 15; i = i + 1)
		begin
			in = sequence[i];
			#2 clk = 1'b1;
			#2 clk = 1'b0;
			$display("State = ", mod.state, ": Input = ", in, ", Output = ", out);
		end
	end
endmodule

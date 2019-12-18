module d_ff(q, d, clk, EN);
	input clk, d, EN;
	output q;
	reg q;
	always @(posedge clk)
	`if(EN)
		q = d;
endmodule

module REG1(clk, EN, numin, numout);
	input [3:0] numin;
	output [3:0] numout;
	input clk, EN;
	genvar j;
	generate for(j=0;j<4;j=j+1)
	d_ff do(numout[j], numin[j], clk, EN);
endmodule

module ROTATOR(clk, Enable, numo, numrotated);
	input [3:0] numo;
	input clk, Enable;
	output [3:0] numrotated;
	reg [3:0] numrotated;
	always @(posedge clk)
		if(Enable)
			{numrotated} = {numo[0], numo[3:1]};
endmodule

module MULTIPLIER(op1, op2, product);
	input [3:0] op1, op2;
	output [7:0] product;
	reg [7:0] product;
	integer count;
	reg [3:0] M, Q,A;
	reg C;
	always @(op1 or op2)
	begin
		 A = 0
		 M = op1;
		 Q = op2;
		 C = 1'b0;
		 count = 4;
		 while(count != 0)
		 begin
		 	if(Q[0])
		 		{C,A} = A + M;
		 	
		 	{C, A, Q} = {1'b0, C, A, Q[3:1]);
		 	count =  count-1;
		 end
	end
endmodule


module DECODER(sel, out);
  input [3:0] sel;
  output  [15:0]  out;
  reg [15:0]  out;
  always  @ (sel) begin
    case(sel)
      4'h0: out = 16'h8000;
      4'h1: out = 16'h4000;
      4'h2: out = 16'h2000;
      4'h3: out = 16'h1000;
      4'h4: out = 16'h0800;
      4'h5: out = 16'h0400;
      4'h6: out = 16'h0200;
      4'h7: out = 16'h0100;
      4'h8: out = 16'h0080;
      4'h9: out = 16'h0040;
      4'hA: out = 16'h0020;
      4'hB: out = 16'h0010;
      4'hC: out = 16'h0008;
      4'hD: out = 16'h0004;
      4'hE: out = 16'h0002;
      4'hF: out = 16'h0001;
    endcase
  end
endmodule

module MEMORY(WE, datatowrite, regsel, readdata);
	input WE;
	input [7:0] datatowrite;
	input [15:0] regsel;
	output [7:0] readdata;
	reg [7:0] readdata;
	reg [7:0] mem[0:15];
	
	always @(WE, regsel, datatowrite, readdata)
		case(regsel)
		16'h8000: begin
		if(WE)
			mem[4'h0] = datatowrite;
		readdata = mem[4'h0];
		end
		16'h4000: begin
		if(WE)
			mem[4'h1] = datatowrite;
		readdata = mem[4'h1];
		end
		16'h2000: begin
		if(WE)
			mem[4'h2] = datatowrite;
		readdata = mem[4'h2];
		end
		16'h1000: begin
		if(WE)
			mem[4'h3] = datatowrite;
		readdata = mem[4'h3];
		end
		16'h0800: begin
		if(WE)
			mem[4'h4] = datatowrite;
		readdata = mem[4'h4];
		end
		16'h0400: begin
		if(WE)
			mem[4'h5] = datatowrite;
		readdata = mem[4'h5];
		end
		16'h0200: begin
		if(WE)
			mem[4'h6] = datatowrite;
		readdata = mem[4'h6];
		end
		16'h0100: begin
		if(WE)
			mem[4'h07] = datatowrite;
		readdata = mem[4'h7];
		end
		16'h0080: begin
		if(WE)
			mem[4'h8] = datatowrite;
		readdata = mem[4'h8];
		end
		16'h0040: begin
		if(WE)
			mem[4'h9] = datatowrite;
		readdata = mem[4'h9];
		end
		16'h0020: begin
		if(WE)
			mem[4'hA] = datatowrite;
		readdata = mem[4'hA];
		end
		16'h0010: begin
		if(WE)
			mem[4'hB] = datatowrite;
		readdata = mem[4'hB];
		end
		16'h0008: begin
		if(WE)
			mem[4'hC] = datatowrite;
		readdata = mem[4'hC];
		end
		16'h0004: begin
		if(WE)
			mem[4'hD] = datatowrite;
		readdata = mem[4'hD];
		end
		16'h0002: begin
		if(WE)
			mem[4'hE] = datatowrite;
		readdata = mem[4'hE];
		end
		16'h0001: begin
		if(WE)
			mem[4'hF] = datatowrite;
		readdata = mem[4'hF];
		end
	endcase
endmodule


module DATAPATH(Num, Key, StoredValue);
  input [3:0] Num, Key;
  output  [7:0] StoredValue;
  reg clock, EN, WE;
  reg [3:0] sel;
  wire  [3:0] RegOut, RotOut1, RotOut2;
  wire  [7:0] Encrypt;
  wire  [15:0]  Addr;
  initial begin
    #0  clock = 1'b1; EN = 1'b1; WE = 1'b1; sel = 4'h8;
  end
  always  begin
    #2  clock = ~clock;
  end
  REG1  mod1(clock, EN, Num, RegOut);
  ROTATOR mod2(clock, EN, RegOut, RotOut1);
  ROTATOR mod3(clock, EN, RotOut1, RotOut2);
  MULTIPLIER  mod4(RotOut2, Key, Encrypt);
  DECODER mod5(sel, Addr);
  MEMORY  mod6(WE, Encrypt, Addr, StoredValue);
endmodule
	
	
		
	
		 	 
	

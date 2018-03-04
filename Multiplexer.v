module mux_4_1(select,a,b,c,d,out);
	input [3:0] a,b,c,d;
	input [1:0] select;
	output reg [3:0] out;
	
	always @(select)
	begin
		case (select)
			0: out = a;
			1: out = b;
			2: out = c;
			3: out = d;
		endcase
	end
endmodule 
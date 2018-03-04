module EQUAL(x, y, out,en);
   input [3:0] x,y;
   output   reg   out;
	input en;

   always @(x,y)
     begin
	if(x == y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // EQUAL

module GREATER(x,y,out,en);
   input [3:0] x,y;
   output 	reg	out;
	input en;

   always @(x,y,en)
     begin
	if(x > y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // GREATER

module LESS(x,y,out,en);
   input [3:0] x,y;
   output   reg   out;
	input en;

   always @(x,y)
     begin
	if(x < y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // LESS

module MAX(x,y,out,en);
	input [3:0] x,y;
	input en;
	output [3:0] out;

	assign out = (x>y) ? x:y;
	
endmodule // MAX

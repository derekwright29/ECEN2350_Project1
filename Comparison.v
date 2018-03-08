module EQUAL(x, y, out);
   input [3:0] x,y;
   output   reg   out;

   always @(x,y)
     begin
	if(x == y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // EQUAL

module GREATER(x,y,out);
   input [3:0] x,y;
   output 	reg	out;

   always @(x,y)
     begin
	if(x > y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // GREATER

module LESS(x,y,out);
   input [3:0] x,y;
   output   reg   out;

   always @(x,y)
     begin
	if(x < y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // LESS

module MAX(x,y,out);
	input [3:0] x,y;
	output [3:0] out;

	assign out = (x>y) ? x:y; // just an inline if-else statement. Can use assign this way.
	
endmodule // MAX

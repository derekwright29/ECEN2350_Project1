module EQUAL(x, y, out,en);
   input [3:0] x,y;
   output      out;

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
   output [3:0] out;

   always @(x,y)
     begin
	if(x > y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // GREATER

module LESS(x,y,out,en);
   input [3:0] x,y;
   output [3:0] out;

   always @(x,y)
     begin
	if(x < y)
	  out = 1;
	else
	  out = 0;
     end
endmodule // LESS

module MAX(x,y,out,en);
   always @(
endmodule // MAX

module AND_D(x,y,out);
   input [3:0] x,y;
   output [3:0] out;
   assign out = x & y;
	
endmodule // AND_D

module OR_D(x,y,out);
   input [3:0] x,y;
   output [3:0] out;

   assign out = x | y;

endmodule // OR_D

module XOR_D(x,y,out);
   input [3:0] x,y;
   output [3:0] out;

   assign out = x ^ y;
	
endmodule // XOR_D

module NOT_D(z,out);
   input [7:0] z;
   output [7:0] out;
   
   assign out = ~z;
 
endmodule // NOT_D


   

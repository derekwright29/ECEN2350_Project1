module fullAdder(cin, x, y, sum, cout);
   input x,y, cin;
   output sum, cout;
   assign sum = x ^ y ^ cin; 
   assign cout = (x & y) | (x & cin) | (y & cin);
endmodule


module Add(x, y, sum, cout); //no ovr used because not a full subtractor/adder.
   parameter n = 4;
   parameter cin = 0; //rarely used. Why waste an input
   
   input [n-1:0] x,y;
   output [n-1:0] sum;
   output 	  cout;
   
   wire [n:0] 	  carries; //n+1 wires for the cout
   
   assign carries[0] = cin;
   assign cout = carries[n];

   genvar 	  i;
   generate
      for (i=0;i<n;i=i+1)
	begin:digit	     
	   fullAdder dig(carries[i],x[i],y[i],sum[i],carries[i+1]);
	end
   endgenerate 
   
endmodule // Add

module fullSub(bin, x, y, diff, bout);
   input bin, x, y;
   output diff, bout;
   
   assign diff = x ^ y ^ bin;
   assign bout = (((~x)&bin) | ((~x)&y) | (y&bin));
endmodule // fullSub

module Sub(x,y,diff,bout);
   parameter n = 4;
   parameter bin = 0;
   
   input [n-1:0] x,y;
   output [n-1:0] diff;
   output 	  bout;
   
   wire [n:0] 	  borrows;
   assign borrows[0] = bin;
   assign bout = borrows[n];
   
   genvar 	  i;
   generate
      for(i=0;i<n; i=i+1)
	begin:digit
	   fullSub(borrows[i],x[i],y[i],diff[i],borrows[i+1]);
	end
   endgenerate
endmodule // Sub



module Mult (x,out,cout);
   input [7:0] x;
   output reg [7:0] out;
   output  reg cout;
   always @(x)
     begin
	if(x[7] == 1)
	  cout = 1;
	else 
		cout = 0;
	out = x << 1;
     end
endmodule

module Div (x,out,rem);
   input [7:0] x;
   output reg [7:0] out;
   output 	reg rem;
   always @(x)
     begin
	if(x[0] == 1)
	  rem = 1;
	else
	  rem = 0;
	out = x >> 1;
     end
endmodule


//Things that need a carryout/overflow/digital indicator output:
// Add, Sub need two: carryout and overflow --bailing on overflow. Making separate adder/subtractor
// Mult/Div need one: carryout
//

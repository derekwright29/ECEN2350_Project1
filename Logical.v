module AND_D(x,y,out,en);
   input [3:0] x,y;
   output reg [3:0] out;

   integer 	i;
   always @(x,y)
     begin
	for(i=0;i<4;i=i+1)
	  begin: dig
	     out[i] = x[i] & y[i];
	  end
     end
endmodule // AND_D

module OR_D(x,y,out,en);
   input [3:0] x,y;
   output reg [3:0] out;

   integer 	i;
   always @(x,y)
     begin
	for(i=0;i<4;i=i+1)
	  begin: dig
	     out[i] = x[i] | y[i];
	  end
     end
endmodule // OR_D

module XOR_D(x,y,out,en);
   input [3:0] x,y;
   output reg [3:0] out;

   integer 	i;
   always @(x,y)
     begin
	for(i=0;i<4;i=i+1)
	  begin: dig
	     out[i] = x[i] ^ y[i];
	  end
     end
endmodule // XOR_D

module NOT_D(z,out,en);
   input [7:0] z;
   output reg [7:0] out;

   integer 	i;
   always @(z)
     begin
	out = ~z;
     end
endmodule // NOT_D


   

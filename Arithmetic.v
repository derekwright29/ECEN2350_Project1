module fullAdder(cin, x, y, sum, cout);
	input x,y, cin;
	output sum, cout;
	assign sum = x ^ y ^ cin; 
	assign cout = (x & y) | (x & cin) | (y & cin);
endmodule


module Add(x, y, sub, sum, cout,ovr);
	parameter n = 4;
	parameter cin = 0; //rarely used. Why waste an input
	
	input [n-1:0] x,y;
	input sub;
	output [n-1:0] sum;
	output cout,ovr;
	
	wire [n:0] carries; //n+1 wires for the cout
	
	assign carries[0] = cin;
	assign cout = ~carries[n];

	genvar i;
	generate
		for (i=0;i<n;i=i+1)
		begin:digit
			fullAdder dig(carries[i],x[i],y[i],sum[i],carries[i+1]);
		end
	endgenerate 
	
	
endmodule

module magic(clk,led_reg);
   input clk;
   output reg [13:0] led_reg;
   wire 	     dir;
   
   always @(posedge clk);
   begin
      if
   end
endmodule // magic

module clock_div(clk, new_clk);
   parameter n = 1000000;
   input clk;
   output reg new_clk;
   
   reg [19:0] count;
   
   
   always @(posedge clk);
   begin
      if (count == n)
	begin
	   count = 0;
	   new_clk = ~new_clk;
	end
   end
	
endmodule

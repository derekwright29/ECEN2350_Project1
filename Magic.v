module magic(clk,led_reg);
   input clk;
   output  reg [11:0] led_reg;
   reg 	     dir;
	initial
	begin
		//init led_reg
		led_reg = 96;
	end
   always @(posedge clk)
   begin
      if(dir)
		begin
			if(led_reg[0])
				dir = ~dir;
			else
				led_reg = led_reg >> 1;
		end
		else
		begin
			if(led_reg[11])
				dir = ~dir;
			else
				led_reg = led_reg << 1;
		end
		
   end
endmodule // magic

module clock_div(clk, new_clk);
   parameter n = 1000000;
   input clk;
   output reg new_clk;
   
   reg [19:0] count;
   
   
   always @(posedge clk)
   begin
      if (count == n)
		begin
			count = 0;
			new_clk = ~new_clk;
		end
		else
			count = count + 1;
   end
	
endmodule

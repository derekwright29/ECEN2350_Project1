module magic(clk,led_reg);
	input clk;
	output led_reg;
	
	always @(posedge clk);
		begin
		
		end
		
		
endmodule


module clock_div(clk, new_clk);
	parameter n = 10000;
	input clk;
	output reg new_clk;
	
	reg [13:0] count;
	
	
	always @(posedge clk);
	begin
		if (count == 10000)
		begin
			count = 0;
			new_clk = new_clk ^ 1;
		end
	end
	
endmodule

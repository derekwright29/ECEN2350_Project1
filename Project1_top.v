//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module Project1_top(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////

	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
	//arithmetic outs
	wire [3:0] add_out;
	wire [3:0] sub_out;
	wire [3:0] mult_out;
	wire [3:0] div_out;
	//logic outs
	wire [3:0] or_out;
	wire [3:0] and_out;
	wire [3:0] xor_out;
	wire [7:0] not_out;
	//comparison outs
	wire [3:0] greater_out;
	wire [3:0] less_out;
	wire [3:0] eq_out;
	wire [3:0] max_out;
	//reg for magic LEDS
	reg [11:0] magic_out;
	
//	//final out to 7-seg
	wire [3:0] mux_out;
	
	wire [3:0] arith_out;
	wire [3:0] comp_out;
	wire [3:0] log_out;
	wire [3:0] magic;
	assign magic = 0;
	
	wire carry_out;
	wire overflow;

	reg [1:0] buttons;


//=======================================================
//  Structural coding
//=======================================================
	//Turn off middle two seven-segs
	SevenSeg make_blank0(0,HEX2[6:0],1);
	assign HEX2[7] = 0;
	SevenSeg make_blank1(0,HEX3[6:0],1);
	assign HEX3[7] = 0;
	
	// Keep track of button sate control
	always @(posedge KEY[1])
	begin
		buttons[1] = buttons[1] ^ 1;
	end
	
	always @(posedge KEY[0])
	begin
		buttons[0] = buttons[0] ^ 1;
	end
		
		
		
	//Higher level mux: Log, Arith, Comp, Magic	
	mux_4_1 gp_out(buttons, arith_out,comp_out,log_out,magic, mux_out);
	
	//Lower level mux for input selection
	mux_4_1 logic_out(SW[8:9],and_out,or_out,xor_out,not_out,log_out);
	
	mux_4_1 comparison_out(SW[9:8], greater_out,less_out,eq_out,max_out,comp_out);
	
	mux_4_1 arithmetic_out(SW[9:8],add_out,sub_out,mult_out,div_out,arith_out);
	
	//input displayed left two dispays
	SevenSeg input1(SW[7:4],HEX5[6:0],0);
	SevenSeg input2(SW[3:0],HEX4[6:0],0);
	
	

endmodule

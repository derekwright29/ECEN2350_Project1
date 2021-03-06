//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

//TODO: make all wires 8-bits wide. Make the final mux_out handle this. and any other in-module places
//TODO: Figure out how to turn on magic or just have it going always...?

module Project1_top(
		    
		    //////////// CLOCK //////////
		    input 	 ADC_CLK_10,
		    input 	 MAX10_CLK1_50,
		    input 	 MAX10_CLK2_50,
		    
		    //////////// SEG7 //////////
		    output [7:0] HEX0,
		    output [7:0] HEX1,
		    output [7:0] HEX2,
		    output [7:0] HEX3,
		    output [7:0] HEX4,
		    output [7:0] HEX5,
		    
		    //////////// KEY //////////
		    
		    input [1:0]  KEY,
		    
		    //////////// LED //////////
		    output [9:0] LEDR,
		    
		    //////////// SW //////////
		    input [9:0]  SW
		    );
   //=======================================================
   //  REG/WIRE declarations
   //=======================================================
   //arithmetic outs
   wire [3:0] 			 add_out, sub_out;
   wire [7:0] 			 mult_out,div_out;
   //logic outs
   wire [3:0] 			 or_out,and_out,xor_out;
   wire [7:0] 			 not_out;
   //comparison outs
   wire 					 greater_out,less_out,eq_out;
   wire [3:0]			 max_out;
   //wires for magic LEDS
	wire[11:0] 			 magic_int;
	reg[11:0]			 magic_out;
	assign LEDR[9:0] = magic_out[10:1];
	
	//clock for magic
	wire 					magic_clk;
   
   //	//final out to 7-seg
   wire [7:0] 			 mux_out;
   
   wire [7:0] 			 arith_out;
   wire [3:0] 			 comp_out;
   wire [7:0] 			 log_out;
   
	wire 			 	carry_int;
	reg 			carry_out;
	wire 			 borrow_int;
	reg 			borrow_out;
	assign HEX0[7] = ~carry_out; //not because hex LEDs are active low
	assign HEX1[7] = ~borrow_out;
	wire 				mult_cint;
	reg 			mult_cout;
	wire 				div_rem_int;
	reg 			div_rem;
	assign HEX2[7] = ~mult_cout;
	assign HEX3[7] = ~div_rem;
   
   reg [1:0] 			 buttons;
	wire [1:0] 			 switches;
	assign switches = SW[9:8];
	
	//user input. Saves typing SW[7:4] over and over.
	wire [3:0] x,y;
	wire [7:0] z;
	assign x = SW[7:4];
	assign y = SW[3:0];
	assign z = SW[7:0]; // same as {x,y}
   
	 //=======================================================
	 //  Structural coding
	 //=======================================================
	 
    //Turn off middle two seven-segs
   SevenSeg make_blank0(0,HEX2[6:0],1);
   SevenSeg make_blank1(0,HEX3[6:0],1);
	//I don't use these LEDs
	assign HEX4[7] = 1;
	assign HEX5[7] = 1;
   
   //Button sate control
   always @(posedge KEY[1])
     begin
	buttons[1] = ~buttons[1];
     end
   always @(posedge KEY[0])
     begin
		buttons[0] = ~buttons[0];
     end
	  
	//case handling for magic, as well as binary LED outputs for Arithmetic module
	always @(buttons,switches)
	begin
		magic_out = 0;
		carry_out = 0;
		borrow_out = 0;
		mult_cout = 0;
		div_rem = 0;
		if (buttons == 0)
		begin
			case(switches)
				0: carry_out = carry_int;
				1: borrow_out = borrow_int;
				2: mult_cout = mult_cint;
				3: div_rem = div_rem_int;
			endcase
		end
		else if (buttons == 3)
			magic_out = magic_int;
	
	end
   
  //Higher level mux: Log, Arith, Comp, Magic	
  mux_4_1 gp_out(buttons, arith_out,comp_out,log_out,magic, mux_out);
  //Arith: 00; Comp : 01; Log: 10; Magic: don't care, zeroes.
  //
   
  //Lower level mux for input selection
  mux_4_1 logic_out(switches,and_out,or_out,xor_out,not_out,log_out);
  //AND: 00; OR:01; XOR:10; NOT:11
   
  mux_4_1 comparison_out(switches,greater_out,less_out,eq_out,max_out,comp_out);
  //GR:00; LESS:01; EQ:10; MAX: 11
  
  mux_4_1 arithmetic_out(switches,add_out,sub_out,mult_out,div_out,arith_out);
  //Add:00; Sub:10; Mult:10; Div:11
   
   //user input displayed left two dispays. Helps debug and tell which mode we are in.
   SevenSeg input1(x,HEX5[6:0],0);
   SevenSeg input2(y,HEX4[6:0],0);
	
	//output to sevensegs
	SevenSeg output1(mux_out[7:4],HEX1[6:0],0);
	SevenSeg output2(mux_out[3:0],HEX0[6:0],0);
   
	//Instantiate all modules
	//Logic
   OR_D(x,y,or_out);
   AND_D(x,y,and_out);
   XOR_D(x,y,xor_out);
   NOT_D(z,not_out);
	//Comparison
   GREATER(x,y,greater_out);
   LESS(x,y,less_out);
   EQUAL(x,y,eq_out);
   MAX(x,y,max_out);
	//Arithmetic
	Sub(x,y,sub_out, borrow_int);
	Add(x,y,add_out, carry_int);
   Div(z,div_out,div_rem_int);
   Mult(z, mult_out,mult_cint);
	//Magic
	clock_div(MAX10_CLK1_50, magic_clk);
	magic(magic_clk, magic_int);

endmodule

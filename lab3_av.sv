// Audrey Vo
// avo@hmc.edu
// 9/12/2024
// This code controls the the 7-segment display based on the input of the switcbes for a common cathode.
module lab3 (input logic inv_reset,
		input logic async_C0, async_C1, async_C2, async_C3,
		output logic [6:0] sevenSeg,
		output logic R0, R1, R2, R3,
		output logic selector1, selector2,
		output logic button_on_debug,
		output logic en
		);
	logic [7:0] keypad_val;
	logic int_osc;
	logic grid;
	logic [3:0] s, s1, s2;
	logic button_on;
	logic [7:0] no_bounce_keypad;
	logic C0, C1, C2, C3;
	logic selector1, selector2;
	logic pulse; // not included right now
	logic [3:0] mux_s;
	logic reset;
	assign reset = ~inv_reset;
	logic real_en;

	// Internal high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
	
	logic new_clk = 1;
	logic [24:0] counter = 0;
	
	// Simple clock divider
	always_ff @(posedge int_osc)
		begin
			// checks if counter has hit 10M (to get 2.4 Hz signal)
			if(counter != 1000) counter <= counter + 1;
			else if (counter == 1000 & new_clk == 0) 
				begin 
					new_clk <= 1;
					counter <= 0;
				end
			else if (counter == 1000 & new_clk == 1) 
				begin 
					new_clk <= 0;
					counter <= 0;
				end
		end 
	

	// synchronizes the keypad inputs
	synchronizer s3 (new_clk, reset, async_C0, async_C1, async_C2, async_C3, C0, C1, C2, C3);
	
	// FSM that scans the keypad
	keypad_scanner s0 (new_clk, reset, async_C0, async_C1, async_C2, async_C3, keypad_val, button_on, en, R0, R1, R2, R3);
	
	// takes care of debouncing when button is clicked
	debounce s5 (new_clk, keypad_val, button_on, no_bounce_keypad, real_en);

	// decodes the switch value from the rows and columns turned on
	keypad_decoder s6 (keypad_val, s);

	// stores the memory of the digits
	two_digit_mem s4 (new_clk, reset, s, en, s1, s2);

	// internal oscillator that outputs 2 selectors
	selector_checker s7 (new_clk, selector1, selector2);
	
	// mux module called that outputs the desired segment input
	mux s8 (s1, s2, selector1, mux_s);

	// seven Segment code from Lab 1
	sevenSeg s9 (mux_s, sevenSeg);

	assign button_on_debug = en;

	

endmodule
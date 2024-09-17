// Audrey Vo
// avo@hmc.edu
// 9/12/2024
// This code controls the the scanning for the keypad to determine which columns and rows are turned on.
module keypad_scanner (input logic clk, reset, C0, C1, C2, C3,
		output logic [7:0] keypad_val,
		output logic button_on,
		output logic en,
		output logic R0, R1, R2, R3
		);
	
	//keypad_val = {R0, R1, R2, R3, C0, C1, C2, C3};
	
	//logic [3:0] state, nextstate;
	assign button_on = C0 | C1 | C2 | C3;
	
	// define various FSM states
	// typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11} statetype;
	//statetype state, nextstate;

	enum int {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11} state, nextstate;
	

	always_ff @(posedge clk)
		if (reset)  state <= S0;
		else        state <= nextstate;
	
	always_comb
		case (state)
		// checking which row is on
		S0: if(button_on) nextstate = S10;
		    else nextstate = S1;
		S1: if(button_on) nextstate = S4;
		    else nextstate = S2;
		S2: if(button_on) nextstate = S6;
		    else nextstate = S3;
		S3: if(button_on) nextstate = S8;
		    else nextstate = S0;
		//decoder state
		S4: if(button_on) nextstate = S5;
		    else nextstate = S1;
		// holding state
		S5: if(button_on) nextstate = S5;
		    else nextstate = S1;
		//decoder state
		S6: if(button_on) nextstate = S7;
		    else nextstate = S2;
		// holding state
		S7: if(button_on) nextstate = S7;
		    else nextstate = S2;
		//decoder state
		S8: if(button_on) nextstate = S9;
		    else nextstate = S3;
		// holding state
		S9: if(button_on) nextstate = S9;
		    else nextstate = S3;
		//decoder state
		S10: if(button_on) nextstate = S11;
		    else nextstate = S0;
		// holding state
		S11: if(button_on) nextstate = S11;
		    else nextstate = S0;
		default: nextstate = S0;
		endcase

	// output logic
	assign R0 = (state == S0) || (state == S10) || (state == S11);
	assign R1 = (state == S4) || (state == S1) || (state == S5);
	assign R2 = (state == S6) || (state == S2) || (state == S7);
	assign R3 = (state == S9) || (state == S8) || (state == S3);
	
	assign en = (state == S6) || (state == S8) || (state == S10) || (state == S4);

	assign keypad_val = {R0, R1, R2, R3, C0, C1, C2, C3}; 

endmodule
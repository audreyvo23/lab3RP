// Audrey Vo
// avo@hmc.edu
// 9/12/2024
// This code outputs the keypad values not bounced.
module debounce(input logic clk,
	input logic [7:0] keypad_val,
	input logic button_on, en_ks,
	output logic [7:0] no_bounce_keypad,
	output logic [24:0] counter);

	//logic [24:0] counter = 0;
	//logic [24:0] en_counter = 0;
	logic [24:0] encounter = 0;
	logic real_en;
	
	// really complicated clock divider
	always_ff @(posedge clk)
		if(button_on) begin
			if(counter > 50) begin 
				counter <= counter;
				encounter <= encounter +1;
				no_bounce_keypad <= keypad_val;
					if(encounter == 51) real_en <= 1;
					else real_en <= 0;
			end
			else begin 
				counter <= counter + 1;
				encounter <= encounter + 1;
				no_bounce_keypad <= 0;
				real_en <= 0;
			end
		end 
		else begin counter <= 0;
			real_en <= 0;
			encounter <= 0;
		end

	/*logic hold_en;

	always_ff @(posedge clk)
		if(en_ks) begin
				if(en_counter == 51) begin 
				en_counter <= en_counter + 1;
				assign real_en = 1;
			end
			else if (en_counter > 51) begin 
				en_counter <= 0;
				assign real_en = 0;
			end
			else begin
				en_counter <= en_counter + 1;
				assign real_en = 0;
			end
		end 
		*/
	

endmodule

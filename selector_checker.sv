// Audrey Vo
// avo@hmc.edu
// 9/9/2024
// This code creates two selectors of alternating value at a fast frequency
module selector_checker(input logic clk, 
				output logic selector1, selector2);

	
	logic led_state = 1;
	logic [24:0] counter = 0;
	
	
	// Simple clock divider
	always_ff @(posedge clk)
		begin
			// checks if counter has hit 10M (to get 2.4 Hz signal)
			if(counter != 100) counter <= counter + 1;
			else if (counter == 100 & selector1 == 0) 
				begin 
					led_state <= 1;
					counter <= 0;
				end
			else if (counter == 100 & selector1 == 1) 
				begin 
					led_state <= 0;
					counter <= 0;
				end
		end
	
	// turns led on or off
	assign selector1 = led_state;
	assign selector2 = ~led_state;
		
endmodule
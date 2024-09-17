// Audrey Vo
// avo@hmc.edu
// 9/9/2024
// This code is a 2 bit mux.
module mux (input logic [3:0] s1, s2,
					input logic selector,
					output logic [3:0] mux_s);
					
	always_comb 
		begin
			case(selector)
				// assigns output variable based on input of selector
				1'b0: 	mux_s = s1;
				1'b1:	mux_s = s2;
			endcase
	end
	
	

endmodule
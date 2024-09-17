// Audrey Vo
// avo@hmc.edu
// 9/12/2024
// This code controls the the synchronization of keypad inputs.
module synchronizer (input logic clk, reset,
                    input logic async_C0, async_C1, async_C2, async_C3,
                    output logic C0, C1, C2, C3);
    
    logic first_temp_state_C0;
    logic first_temp_state_C1;
    logic first_temp_state_C2;
    logic first_temp_state_C3;

    logic second_temp_state_C0;
    logic second_temp_state_C1;
    logic second_temp_state_C2;
    logic second_temp_state_C3;


    always_ff @(posedge clk)
        if (reset)    begin
                first_temp_state_C0 <= 0;
                first_temp_state_C1 <= 0;
                first_temp_state_C2 <= 0;
                first_temp_state_C3 <= 0;
        end
		else       begin
                first_temp_state_C0 <= async_C0;
                first_temp_state_C1 <= async_C1;
                first_temp_state_C2 <= async_C2;
                first_temp_state_C3 <= async_C3;
        end

    always_ff @(posedge clk)
        if (reset)   begin
                second_temp_state_C0 <= 0;
                second_temp_state_C1 <= 0;
                second_temp_state_C2 <= 0;
                second_temp_state_C3 <= 0;
        end
		else       begin
                second_temp_state_C0 <= first_temp_state_C0;
                second_temp_state_C1 <= first_temp_state_C1;
                second_temp_state_C2 <= first_temp_state_C2;
                second_temp_state_C3 <= first_temp_state_C3;
        end

    always_ff @(posedge clk)
        if (reset)   begin
                C0 <= 0;
                C1 <= 0;
                C2 <= 0;
                C3 <= 0;
        end
		else       begin
                C0 <= second_temp_state_C0;
                C1 <= second_temp_state_C1;
                C2 <= second_temp_state_C2;
                C3 <= second_temp_state_C3;
        end


    

endmodule
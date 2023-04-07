module StateGm(
        	input clk, clk_1ms, reset,
        	input [3:0] p1_scr, p2_scr,
        	output reg [1:0] stateGm
        	);
        	//check at every clock change what is the state
        	always @ (posedge clk)
        	begin
                    	if (!reset)
                                	stateGm = 0; //begin
                    	else
                    	begin
                                	if ( p1_scr == 4'b0101)
                                            	stateGm = 2'b10;//player ONE won
                                            	 
                                	else if ( p2_scr == 4'b0101)
                                            	stateGm = 2'b11;//player TWO won
                                               
                                	else
                                            	stateGm = 2'b01;//still playing
                    	end
        	end
 
endmodule

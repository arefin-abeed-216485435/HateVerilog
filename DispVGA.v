module DispVGA(
        	input clk, reset,
        	input [9:0] x, y,//position of point
        	input video,
        	output [11:0]redgrnblu,
        	input clk_1ms,
        	input pdl1_on, pdl2_on, ball_on,
        	input [11:0]redgrnblu_pdl1, redgrnblu_pdl2, redgrnblu_ball,
        	input [1:0] stateGm
        	);
           
        	reg [11:0] redgrnblu_reg;
           
        	always @(posedge clk)
        	begin
        	if (!reset)
                    	redgrnblu_reg <= 0;
        	else
                    	begin
                       
                    		if (stateGm == 2'b10)
                    		begin
                                            	redgrnblu_reg <= redgrnblu_pdl1;
                                	end
                                	else if (stateGm == 2'b01)
                                	begin
                                	//drawing components on screen by detecting if object signal is on
                                            	if (pdl2_on)
                                                        	redgrnblu_reg <= redgrnblu_pdl2;
                                            	else if (pdl1_on)
                                                        	redgrnblu_reg <= redgrnblu_pdl1;
                                            	else if (ball_on)
                                                        	redgrnblu_reg <= redgrnblu_ball;
                                            	else
                                                        	redgrnblu_reg <= 12'b111111111111;
                                	end
                                	else if (stateGm == 2'b11)
                                            	redgrnblu_reg <= redgrnblu_pdl2;
                                	else redgrnblu_reg <= 0;
                    	end
        	end
        	//if video on then display
        	assign redgrnblu = (video) ? redgrnblu_reg : 8'b0;
           
endmodule

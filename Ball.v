module Ball(
        	input clk,clk_1ms,reset,
        	input [9:0] x, y,
        	output ball_on,
        	output [11:0] rgb_ball,
        	input [9:0] x_pdl1, x_pdl2, y_pdl1, y_pdl2,
        	output reg [3:0]  p1_scr, p2_scr,
        	input [1:0] stateGm
        	);
           
        	//instantaneous direction of the ball
        	integer dx = 1, dy = 1;
           
        	//current position of the ball
        	reg [9:0] x_ball, y_ball;
                       
        	always @ (posedge clk_1ms)
        	begin
                    	if(!reset)
                    	begin
                                	x_ball <= 640/2;
                                	y_ball <= 480/2;
                                	p1_scr <= 0;
                                	p2_scr <= 0;   
                    	end
                    	else if (stateGm == 2'b01)
                    	begin
                       
                                	// collision with the screen edges
                                	if ((y_ball == (16/2)+1) || (y_ball == (480-(16/2)-1)))
                                            	dy = dy*-1;
 
                                	// after collision with the pdl,the direction of the ball changes
                                	if ((x_ball > (x_pdl2-16/2) && y_ball > (y_pdl2 - 80/2) && y_ball < (y_pdl2 + 80/2))
                                	|| (x_ball < (x_pdl1+16/2) && y_ball > (y_pdl1 - 80/2) && y_ball < (y_pdl1 + 80/2)))
                                            	dx = dx*-1;
                                   
                                	//which half of the screen was the ball -> other side wins
                                	if (x_ball == (640 -16/2))
                                	begin
                                            	x_ball <= 640/2;
                                            	y_ball <= 480/2;
                                            	dy = dy*-1;
                                            	dx = dx*-1;
                                            	p1_scr <= p1_scr+1;
                                	end
                                	else if (x_ball == 0)
                                	begin
                                            	x_ball <= 640/2;
                                            	y_ball <= 480/2;
                                            	dy = dy*-1;
                                            	dx = dx*-1;
                                            	p2_scr <= p2_scr+1;
                                	end
                                	else
                                	begin
                                            	x_ball <= x_ball + dx;
                                            	y_ball <= y_ball + dy; 
                                	end
                    	end
                    	else
                    	//stagnant state -> no hits
                    	begin
                                	x_ball <= x_ball;
                                	y_ball <= y_ball;
                    	end     
        	end
                       
        	assign ball_on = (x >= x_ball-(16/2) && x <= x_ball+(16/2) && y >= y_ball-(16/2) && y <= y_ball+(16/2))?1:0;
           
        	//design to render
        	assign rgb_ball = 12'b000011111111;
           
           
           
endmodule

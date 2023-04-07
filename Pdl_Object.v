module Pdl_Object(
        	input clk_1ms,reset,
        	input btn, btn1, btn2, btn3,
        	input [9:0] x, y,
           
        	output pdl1_on,pdl2_on,
           
           
        	output [11:0] rgb_pdl1, rgb_pdl2,
        	output reg [9:0] x_pdl1 = L_pos + (pdlwidth/2),
        	output reg [9:0] y_pdl1 = V_active/2,
        	output reg [9:0] x_pdl2 = H_active-(R_pos + (pdlwidth/2)),
        	output reg [9:0] y_pdl2 = V_active/2
        	);
           
           
        	//Player One's pdl
        	always @ (posedge clk_1ms)
        	begin
                    	if(!reset) //take initial pos
                    	begin  
                                	x_pdl1 <= 20 + (16/2);
                                	y_pdl1 <= 480/2;
                                   
                                	x_pdl2 <= 640-(20 + (16/2));
                                	y_pdl2 <= 480/2;
                    	end
                       
                    	else if (!btn && y_pdl1-(80/2) > 0)
                                	y_pdl1 <= y_pdl1-1;
                    	else if (!btn1 && y_pdl1+(80/2) < 480)
                                	y_pdl1 <= y_pdl1+1;
                                   
                    	else if (!btn2 && y_pdl2-(80/2) > 0)
                                	y_pdl2 <= y_pdl2-1;
                    	else if (!btn3 && y_pdl2+(80/2) < 480 )
                                	y_pdl2 <= y_pdl2+1;
                                   
                    	else
                    	begin
        		    	y_pdl1 <= y_pdl1;
        		    	y_pdl2 <= y_pdl2;
                    	end
        	end
        	//whose turn is it?
        	assign pdl1_on = (x >= x_pdl1-(16/2) && x <= x_pdl1+(16/2) && y >= y_pdl1-(80/2) && y < y_pdl1+(80/2))?1:0;
        	assign pdl2_on = (x >= x_pdl2-(16/2) && x <= x_pdl2+(16/2) && y >= y_pdl2-(80/2) && y < y_pdl2+(80/2))?1:0;
 
        	assign rgb_pdl1 = 12'b111100000000;
        	assign rgb_pdl2 = 12'b000000001111;
           
           
endmodule

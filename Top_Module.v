module Top_Module (
        	input clk, reset, btn, btn1, btn2, btn3,
        	output [11:0] redgrnblu,
        	output hsync, vsync,
        	output [6:0] seg1, seg2
        	);
           
           
        	wire [9:0] tempx,tempy;
           
        	wire video;
        	wire clk_1ms;
           
        	wire [11:0] redgrnblu_pdl1, redgrnblu_pdl2, redgrnblu_ball;
        	wire ball_on, pdl1_on, pdl2_on;
        	wire [9:0] tempx_pdl1, tempx_pdl2, tempy_pdl1, tempy_pdl2;
        	wire [3:0] p1_score, p2_score;
        	wire [1:0] stateGm;
           
        	VGASigGen v1 (.clk(clk), .hsync(hsync), .vsync(vsync), .tempx(tempx), .tempy(tempy), .video(video));
           
        	DispVGA r1  	(.clk(clk), .reset(reset), .tempx(tempx), .tempy(tempy), .video(video), .redgrnblu(redgrnblu), .clk_1ms(clk_1ms),
                                                        	.pdl1_on(pdl1_on), .pdl2_on(pdl2_on), .ball_on(ball_on),
                                                        	.redgrnblu_pdl1(redgrnblu_pdl1), .redgrnblu_pdl2(redgrnblu_pdl2), .redgrnblu_ball(redgrnblu_ball),
                                                        	.stateGm(stateGm));
                                               
        	Clock_Divider c1 (.clk(clk), .clk_1ms(clk_1ms));
           
        	Ball b1 (.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .tempx(tempx), .tempy(tempy),  .ball_on(ball_on), .redgrnblu_ball(redgrnblu_ball),
                                            	.tempx_pdl1(tempx_pdl1), .tempx_pdl2(tempx_pdl2), .tempy_pdl1(tempy_pdl1), .tempy_pdl2(tempy_pdl2),
                                            	.p1_score(p1_score), .p2_score(p2_score), .stateGm(stateGm));
           
        	Pdl_Object p1 (.clk_1ms(clk_1ms), .reset(reset), .tempx(tempx), .tempy(tempy),
                                                        	 .btn(btn), .btn1(btn1),  .btn2(btn2), .btn3(btn3),
                                                        	.pdl1_on(pdl1_on), .redgrnblu_pdl1(redgrnblu_pdl1), .pdl2_on(pdl2_on), .redgrnblu_pdl2(redgrnblu_pdl2),
                                                        	.tempx_pdl1(tempx_pdl1), .tempx_pdl2(tempx_pdl2), .tempy_pdl1(tempy_pdl1), .tempy_pdl2(tempy_pdl2) );
 
        	StateGm (.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .p1_score(p1_score), .p2_score(p2_score), .stateGm(stateGm));
           
        	Seven_Segment_Display (.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .p1_score(p1_score), .p2_score(p2_score), .seg1(seg1), .seg2(seg2));
 
           
endmodule

module VGASigGen(
        	input clk,reset,
        	output hsync,vsync, video,
        	output [9:0] pxl_x,pxl_y//position of pxl_x and pxl_y. current position of the pxl
        	);
           
           
        	reg pxl_temp;
        	wire pxl_nxt;
        	wire pxl_counter;
        	//current pxl location
        	reg [9:0] h_c_temp, h_c_nxt, v_c_temp, v_c_nxt;
           
        	//vsync and hsync signal states
        	reg vsync_temp, hsync_temp;
        	wire vsync_nxt, hsync_nxt;
           
        	always @(posedge clk, posedge reset)
                    	if(reset)
                    	  pxl_temp <= 0;
                    	  v_c_temp <= 0;
      	h_c_temp <= 0;
      	vsync_temp   <= 0;
      	hsync_temp   <= 0;
                    	else
                    	  pxl_temp <= pxl_nxt;
                    	  v_c_temp <= v_c_nxt;
      	h_c_temp <= h_c_nxt;
      	vsync_temp   <= vsync_nxt;
      	hsync_temp   <= hsync_nxt;
           
        	assign pxl_nxt = pxl_temp + 1;
           
        	assign pxl_counter = (pxl_temp == 0);
           
                                   
        	// horizontal vertical sync counters
        	always @*
                    	begin
                    	if (pxl_counter) begin
	if (h_c_temp == (640 + 60 + 56 + 40 - 1)) begin
    	h_c_nxt = 0;
	end else begin
    	h_c_nxt = h_c_temp + 1;
	end
end else begin
	h_c_nxt = h_c_temp;
end
 
if (pxl_counter && h_c_temp == (640 + 60 + 56 + 40 - 1)) begin
	if (v_c_temp == (480 + 33 + 0 + 2 - 1)) begin
    	v_c_nxt = 0;
	end else begin
    	v_c_nxt = v_c_temp + 1;
	end
end else begin
	v_c_nxt = v_c_temp;
end
                    	end
                       
 
   // hsync signal
   assign hsync_nxt = h_c_temp >= (640 + 56) && h_c_temp <= (640 + 56 + 40 - 1);
  
   // vsync signal
   assign vsync_nxt = v_c_temp >= (480 + 0) && v_c_temp <= (480 + 0 + 2 - 1);
 
   // video only on when pxls within perimeter
   assign video = (h_c_temp < 640) && (v_c_temp < 480);
 
   // output signals
   assign hsync  = hsync_temp;
   assign vsync  = vsync_temp;
   assign pxl_x  	= h_c_temp;
   assign pxl_y  	= v_c_temp;
           
endmodule

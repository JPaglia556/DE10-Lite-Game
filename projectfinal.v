`timescale 1ns / 1ps


////////////////////////////////////////////////////////////////////////
module projectfinal(
	input clk1,           // 50 MHz
	output o_hsync,      // horizontal sync
	output o_vsync,	     // vertical sync
	output [3:0] o_red,
	output [3:0] o_blue,
	output [3:0] o_green,
	output[6:0] o1,
	output[6:0] o2,
	output[6:0] o3,
	output[6:0] o4,


   
   input 		     [1:0]		KEY
);

	reg [9:0] counter_x = 0;  // horizontal counter
	reg [9:0] counter_y = 0;  // vertical counter
	reg [3:0] r_red = 0;
	reg [3:0] r_blue = 0;
	reg [3:0] r_green = 0;
	
	// Seed (recommended to keep between 1000-9999)
	integer SEED = 1873;
	
	wire clk25MHz;
	integer topleftY = 350;
	integer topleftX = 0;
	
	integer asteroidposX = -999;
	integer asteroidposY = 0;
	integer tempRandom = 1;
	
	integer asteroidposX2 = -999;
	integer asteroidposY2 = 0;
	integer tempRandom2 = 2;
	
	integer asteroidposX3 = -999;
	integer asteroidposY3 = 0;
	integer tempRandom3 = 4;
	
	integer asteroidposX4 = -999;
	integer asteroidposY4 = 0;
	integer tempRandom4 = 6;
	
	integer dead = 0;
	
	integer score = 0;
	
	reg[3:0] d1 = 4'd0;
	reg[3:0] d2 = 4'd0;
	reg[3:0] d3 = 4'd0;
	reg[3:0] d4 = 4'd0;
	
	
	

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// clk divider 50 MHz to 25 MHz
	ip ip(
		.areset(reset),
		.inclk0(clk1),
		.c0(clk25MHz),
		.locked()
		);  
	// end clk divider 50 MHz to 25 MHz
	
	// 7 Segment display
	assign o1[6] = (~d1[3] & ~d1[2] & ~d1[1] & d1[0]) | (~d1[3] & d1[2] & ~d1[1] & ~d1[0]) | (d1[3] & ~d1[2] & d1[1] & d1[0]) | (d1[3] & d1[2] & ~d1[1] & d1[0]);
	assign o1[5] = (~d1[3] & d1[2] & ~d1[1] & d1[0]) | (~d1[3] & d1[2] & d1[1] & ~d1[0]) | (d1[3] & ~d1[2] & d1[1] & d1[0]) | (d1[3] & d1[2] & ~d1[1] & ~d1[0]) | (d1[3] & d1[2] & d1[1] & ~d1[0]) | (d1[3] & d1[2] & d1[1] & d1[0]);
	assign o1[4] = (~d1[3] & ~d1[2] & d1[1] & ~d1[0]) | (d1[3] & d1[2] & ~d1[1] & ~d1[0]) | (d1[3] & d1[2] & d1[1] & ~d1[0]) | (d1[3] & d1[2] & d1[1] & d1[0]);
	assign o1[3] = (~d1[3] & ~d1[2] & ~d1[1] & d1[0]) | (~d1[3] & d1[2] & ~d1[1] & ~d1[0]) | (~d1[3] & d1[2] & d1[1] & d1[0]) | (d1[3] & ~d1[2] & d1[1] & ~d1[0]) | (d1[3] & d1[2] & d1[1] & d1[0]);
	assign o1[2] = (~d1[3] & ~d1[2] & ~d1[1] & d1[0]) | (~d1[3] & ~d1[2] & d1[1] & d1[0]) | (~d1[3] & d1[2] & ~d1[1] & ~d1[0]) | (~d1[3] & d1[2] & ~d1[1] & d1[0]) | (~d1[3] & d1[2] & d1[1] & d1[0]) | (d1[3] & ~d1[2] & ~d1[1] & d1[0]);
	assign o1[1] = (~d1[3] & ~d1[2] & ~d1[1] & d1[0]) | (~d1[3] & ~d1[2] & d1[1] & ~d1[0]) | (~d1[3] & ~d1[2] & d1[1] & d1[0]) | (~d1[3] & d1[2] & d1[1] & d1[0]) | (d1[3] & d1[2] & ~d1[1] & d1[0]);
	assign o1[0] = (~d1[3] & ~d1[2] & ~d1[1] & ~d1[0]) | (~d1[3] & ~d1[2] & ~d1[1] & d1[0]) | (~d1[3] & d1[2] & d1[1] & d1[0]) | (d1[3] & d1[2] & ~d1[1] & ~d1[0]);
	
	assign o2[6] = (~d2[3] & ~d2[2] & ~d2[1] & d2[0]) | (~d2[3] & d2[2] & ~d2[1] & ~d2[0]) | (d2[3] & ~d2[2] & d2[1] & d2[0]) | (d2[3] & d2[2] & ~d2[1] & d2[0]);
	assign o2[5] = (~d2[3] & d2[2] & ~d2[1] & d2[0]) | (~d2[3] & d2[2] & d2[1] & ~d2[0]) | (d2[3] & ~d2[2] & d2[1] & d2[0]) | (d2[3] & d2[2] & ~d2[1] & ~d2[0]) | (d2[3] & d2[2] & d2[1] & ~d2[0]) | (d2[3] & d2[2] & d2[1] & d2[0]);
	assign o2[4] = (~d2[3] & ~d2[2] & d2[1] & ~d2[0]) | (d2[3] & d2[2] & ~d2[1] & ~d2[0]) | (d2[3] & d2[2] & d2[1] & ~d2[0]) | (d2[3] & d2[2] & d2[1] & d2[0]);
	assign o2[3] = (~d2[3] & ~d2[2] & ~d2[1] & d2[0]) | (~d2[3] & d2[2] & ~d2[1] & ~d2[0]) | (~d2[3] & d2[2] & d2[1] & d2[0]) | (d2[3] & ~d2[2] & d2[1] & ~d2[0]) | (d2[3] & d2[2] & d2[1] & d2[0]);
	assign o2[2] = (~d2[3] & ~d2[2] & ~d2[1] & d2[0]) | (~d2[3] & ~d2[2] & d2[1] & d2[0]) | (~d2[3] & d2[2] & ~d2[1] & ~d2[0]) | (~d2[3] & d2[2] & ~d2[1] & d2[0]) | (~d2[3] & d2[2] & d2[1] & d2[0]) | (d2[3] & ~d2[2] & ~d2[1] & d2[0]);
	assign o2[1] = (~d2[3] & ~d2[2] & ~d2[1] & d2[0]) | (~d2[3] & ~d2[2] & d2[1] & ~d2[0]) | (~d2[3] & ~d2[2] & d2[1] & d2[0]) | (~d2[3] & d2[2] & d2[1] & d2[0]) | (d2[3] & d2[2] & ~d2[1] & d2[0]);
	assign o2[0] = (~d2[3] & ~d2[2] & ~d2[1] & ~d2[0]) | (~d2[3] & ~d2[2] & ~d2[1] & d2[0]) | (~d2[3] & d2[2] & d2[1] & d2[0]) | (d2[3] & d2[2] & ~d2[1] & ~d2[0]);
	
	assign o3[6] = (~d3[3] & ~d3[2] & ~d3[1] & d3[0]) | (~d3[3] & d3[2] & ~d3[1] & ~d3[0]) | (d3[3] & ~d3[2] & d3[1] & d3[0]) | (d3[3] & d3[2] & ~d3[1] & d3[0]);
	assign o3[5] = (~d3[3] & d3[2] & ~d3[1] & d3[0]) | (~d3[3] & d3[2] & d3[1] & ~d3[0]) | (d3[3] & ~d3[2] & d3[1] & d3[0]) | (d3[3] & d3[2] & ~d3[1] & ~d3[0]) | (d3[3] & d3[2] & d3[1] & ~d3[0]) | (d3[3] & d3[2] & d3[1] & d3[0]);
	assign o3[4] = (~d3[3] & ~d3[2] & d3[1] & ~d3[0]) | (d3[3] & d3[2] & ~d3[1] & ~d3[0]) | (d3[3] & d3[2] & d3[1] & ~d3[0]) | (d3[3] & d3[2] & d3[1] & d3[0]);
	assign o3[3] = (~d3[3] & ~d3[2] & ~d3[1] & d3[0]) | (~d3[3] & d3[2] & ~d3[1] & ~d3[0]) | (~d3[3] & d3[2] & d3[1] & d3[0]) | (d3[3] & ~d3[2] & d3[1] & ~d3[0]) | (d3[3] & d3[2] & d3[1] & d3[0]);
	assign o3[2] = (~d3[3] & ~d3[2] & ~d3[1] & d3[0]) | (~d3[3] & ~d3[2] & d3[1] & d3[0]) | (~d3[3] & d3[2] & ~d3[1] & ~d3[0]) | (~d3[3] & d3[2] & ~d3[1] & d3[0]) | (~d3[3] & d3[2] & d3[1] & d3[0]) | (d3[3] & ~d3[2] & ~d3[1] & d3[0]);
	assign o3[1] = (~d3[3] & ~d3[2] & ~d3[1] & d3[0]) | (~d3[3] & ~d3[2] & d3[1] & ~d3[0]) | (~d3[3] & ~d3[2] & d3[1] & d3[0]) | (~d3[3] & d3[2] & d3[1] & d3[0]) | (d3[3] & d3[2] & ~d3[1] & d3[0]);
	assign o3[0] = (~d3[3] & ~d3[2] & ~d3[1] & ~d3[0]) | (~d3[3] & ~d3[2] & ~d3[1] & d3[0]) | (~d3[3] & d3[2] & d3[1] & d3[0]) | (d3[3] & d3[2] & ~d3[1] & ~d3[0]);
	
	assign o4[6] = (~d4[3] & ~d4[2] & ~d4[1] & d4[0]) | (~d4[3] & d4[2] & ~d4[1] & ~d4[0]) | (d4[3] & ~d4[2] & d4[1] & d4[0]) | (d4[3] & d4[2] & ~d4[1] & d4[0]);
	assign o4[5] = (~d4[3] & d4[2] & ~d4[1] & d4[0]) | (~d4[3] & d4[2] & d4[1] & ~d4[0]) | (d4[3] & ~d4[2] & d4[1] & d4[0]) | (d4[3] & d4[2] & ~d4[1] & ~d4[0]) | (d4[3] & d4[2] & d4[1] & ~d4[0]) | (d4[3] & d4[2] & d4[1] & d4[0]);
	assign o4[4] = (~d4[3] & ~d4[2] & d4[1] & ~d4[0]) | (d4[3] & d4[2] & ~d4[1] & ~d4[0]) | (d4[3] & d4[2] & d4[1] & ~d4[0]) | (d4[3] & d4[2] & d4[1] & d4[0]);
	assign o4[3] = (~d4[3] & ~d4[2] & ~d4[1] & d4[0]) | (~d4[3] & d4[2] & ~d4[1] & ~d4[0]) | (~d4[3] & d4[2] & d4[1] & d4[0]) | (d4[3] & ~d4[2] & d4[1] & ~d4[0]) | (d4[3] & d4[2] & d4[1] & d4[0]);
	assign o4[2] = (~d4[3] & ~d4[2] & ~d4[1] & d4[0]) | (~d4[3] & ~d4[2] & d4[1] & d4[0]) | (~d4[3] & d4[2] & ~d4[1] & ~d4[0]) | (~d4[3] & d4[2] & ~d4[1] & d4[0]) | (~d4[3] & d4[2] & d4[1] & d4[0]) | (d4[3] & ~d4[2] & ~d4[1] & d4[0]);
	assign o4[1] = (~d4[3] & ~d4[2] & ~d4[1] & d4[0]) | (~d4[3] & ~d4[2] & d4[1] & ~d4[0]) | (~d4[3] & ~d4[2] & d4[1] & d4[0]) | (~d4[3] & d4[2] & d4[1] & d4[0]) | (d4[3] & d4[2] & ~d4[1] & d4[0]);
	assign o4[0] = (~d4[3] & ~d4[2] & ~d4[1] & ~d4[0]) | (~d4[3] & ~d4[2] & ~d4[1] & d4[0]) | (~d4[3] & d4[2] & d4[1] & d4[0]) | (d4[3] & d4[2] & ~d4[1] & ~d4[0]);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// counter and sync generation
	always @(posedge clk25MHz)  // horizontal counter
		begin 
			if (counter_x < 799)
				counter_x <= counter_x + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
			else
				counter_x <= 0;              
		end  // always 
	
	always @ (posedge clk25MHz)  // vertical counter
		begin 
			if (counter_x == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (counter_y < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						counter_y <= counter_y + 1;
					else
						counter_y <= 0;              
				end  // if (counter_x...
		end  // always
	// end counter and sync generation  

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// hsync and vsync output assignments
	assign o_hsync = (counter_x >= 0 && counter_x < 96) ? 1:0;  // hsync high for 96 counts                                                 
	assign o_vsync = (counter_y >= 0 && counter_y < 2) ? 1:0;   // vsync high for 2 counts
	// end hsync and vsync output assignments

	
	// Drawing white background and yellow block
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		always @ (posedge clk1)
		begin
			if (counter_y == 1 && counter_x == 1)
				begin
				tempRandom <= tempRandom + 9;
				if (~KEY[1])
					begin
						topleftX <= topleftX + 2;
						tempRandom <= tempRandom + 1;
					end
				if (~KEY[0])
					begin
						topleftX <= topleftX - 2;
						tempRandom <= tempRandom + 2;
					end
					
				if (topleftX > 597)
					begin
						topleftX <= 587;
					end
				if (topleftX < 0)
					begin
						topleftX <= 10;
					end
			end
			if (counter_y < topleftY - 100 + 135)
				begin              
					r_red <= 4'hF;    // white
					r_blue <= 4'hF;
					r_green <= 4'hF;
				end 
			else if (counter_y >= topleftY - 100 + 135 && counter_y < topleftY - 100 + 205)
				begin 
					if (counter_x < topleftX - 180 + 324)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end 
					else if (counter_x >= topleftX + 144 && counter_x < topleftX + 184)
						begin 
							r_red <= 4'hF;    // yellow
							r_blue <= 4'h0;
							r_green <= 4'hF;
						end  
					else if (counter_x >= topleftX + 184)
						begin 
							r_red <= 4'hF;    // white
							r_blue <= 4'hF;
							r_green <= 4'hF;
						end  
					end  
					
					
					
			//Drawing asteroid 1
			//////////////////////////////////////////////////////
			if (asteroidposX == -999)
				begin
					tempRandom <= tempRandom + 3;
					asteroidposX <= ((tempRandom) % 10 * 85) + ((tempRandom) % 20);
					
				end
				
			if (dead == 0)
				begin
				if (asteroidposY < 513 && (counter_y == 1 && (counter_x == 30 || counter_x == 50 || counter_x == 70 || counter_x == 80)))
					begin
						asteroidposY <= asteroidposY + 1;
					end
				end
				
			if (counter_y > asteroidposY && counter_y < asteroidposY + 10)
				begin
					if (counter_x > asteroidposX && counter_x < asteroidposX + 40)
						begin
							r_red <= 4'hF;    
							r_blue <= 4'hF;
							r_green <= 4'h0;
						end
				end
			
			if(asteroidposY == 500)
				begin
					asteroidposX <= -999;
					asteroidposY <= 0;
					score <= score + 1;
				end
			//////////////////////////////////////////////////////////
	
			//Drawing asteroid 2
			//////////////////////////////////////////////////////
			if (asteroidposX2 == -999)
				begin
					tempRandom2 <= tempRandom2 + 3;
					asteroidposX2 <= ((tempRandom2) % 10 * 85) + ((tempRandom2) % 33);
					
				end
				
			if (dead == 0)
				begin		
				if (asteroidposY2 < 513 && (counter_y == 1 && (counter_x == 10 || counter_x == 35)))
					begin
						asteroidposY2 <= asteroidposY2 + 1;
					end
				end
				
			if (counter_y > asteroidposY2 && counter_y < asteroidposY2 + 10)
				begin
					if (counter_x > asteroidposX2 && counter_x < asteroidposX2 + 80)
						begin
						r_red <= 4'hF;    
						r_blue <= 4'hF;
						r_green <= 4'h0;
						end
				end
			
			if(asteroidposY2 == 500)
				begin
					asteroidposX2 <= -999;
					asteroidposY2 <= 0;
					score <= score + 1;
				end
			//////////////////////////////////////////////////////////
			
			//Drawing asteroid 3
			//////////////////////////////////////////////////////
			if (asteroidposX3 == -999)
				begin
					tempRandom3 <= tempRandom3 + 3;
					asteroidposX3 <= ((tempRandom3) % 10 * 85) + ((tempRandom3) % 44);
					
				end
				
			if (dead == 0)
				begin
				if (asteroidposY3 < 513 && (counter_y == 1 && (counter_x == 30 || counter_x == 50 || counter_x == 70 || counter_x == 80|| counter_x == 60)))
					begin
						asteroidposY3 <= asteroidposY3 + 1;
					end
				end
			
			if (counter_y > asteroidposY3 && counter_y < asteroidposY3 + 10)
				begin
					if (counter_x > asteroidposX3 && counter_x < asteroidposX3 + 10)
						begin
						r_red <= 4'hF;    
						r_blue <= 4'hF;
						r_green <= 4'h0;
						end
				end
			
			
			if(asteroidposY3 == 500)
				begin
					asteroidposX3 <= -999;
					asteroidposY3 <= 0;
					score <= score + 1;
				end
			//////////////////////////////////////////////////////////
			
			//Drawing asteroid 4
			//////////////////////////////////////////////////////
			if (asteroidposX4 == -999)
				begin
					tempRandom4 <= tempRandom4 + 3;
					asteroidposX4 <= ((tempRandom4) % 10 * 85) + ((tempRandom4) % 27);
					
				end
				
			if (dead == 0)
				begin	
				if (asteroidposY4 < 513 && (counter_y == 1 && (counter_x == 30)))
					begin
						asteroidposY4 <= asteroidposY4 + 1;
					end
				end
			
			if (counter_y > asteroidposY4 && counter_y < asteroidposY4 + 10)
				begin
					if (counter_x > asteroidposX4 && counter_x < asteroidposX4 + 150)
						begin
						r_red <= 4'hF;    
						r_blue <= 4'hF;
						r_green <= 4'h0;
						end
				end
			
			
			if(asteroidposY4 == 500)
				begin
					asteroidposX4 <= -999;
					asteroidposY4 <= 0;
					score <= score + 1;
				end
			//////////////////////////////////////////////////////////

			
			/// ASTEROID 1 HIT DETECTION
			if (asteroidposY > 385 && asteroidposY < 455)
				begin
					if (asteroidposX > topleftX + 144 && asteroidposX < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
						
					if (asteroidposX + 40 > topleftX + 144 && asteroidposX + 40 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
						
				end
			/// ASTEROID 1 HIT DETECTION END
			
			/// ASTEROID 2 HIT DETECTION
			if (asteroidposY2 > 385 && asteroidposY2 < 455)
				begin
					if (asteroidposX2 > topleftX + 144 && asteroidposX2 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
						
					if (asteroidposX2 + 40 > topleftX + 144 && asteroidposX2 + 40 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
					
					if (asteroidposX2 + 80 > topleftX + 144 && asteroidposX2 + 80 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
						
				end
			/// ASTEROID 2 HIT DETECTION END
			
			/// ASTEROID 3 HIT DETECTION
			if (asteroidposY3 > 385 && asteroidposY3 < 455)
				begin
					if (asteroidposX3 > topleftX + 144 && asteroidposX3 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
						
					if (asteroidposX3 + 10 > topleftX + 144 && asteroidposX3 + 10 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
					

						
				end
			/// ASTEROID 3 HIT DETECTION END
			
			/// ASTEROID 4 HIT DETECTION
			if (asteroidposY4 > 385 && asteroidposY4 < 455)
				begin
					if (asteroidposX4 > topleftX + 144 && asteroidposX4 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
						
					if (asteroidposX4 + 40 > topleftX + 144 && asteroidposX4 + 40 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
					
					if (asteroidposX4 + 80 > topleftX + 144 && asteroidposX4 + 80 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
					if (asteroidposX4 + 120 > topleftX + 144 && asteroidposX4 + 120 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
					if (asteroidposX4 + 150 > topleftX + 144 && asteroidposX4 + 150 < topleftX + 40 + 144)
						begin
							dead <= 1;
						end
						
				end
			/// ASTEROID 4 HIT DETECTION END
			
			//Game reset
			if (dead == 1 && ~KEY[1] && ~KEY[0])
				begin
				
					asteroidposX <= -999;
					asteroidposY <= 0;
					asteroidposX2 <= -999;
					asteroidposY2 <= 0;
					asteroidposX3 <= -999;
					asteroidposY3 <= 0;
					asteroidposX4 <= -999;
					asteroidposY4 <= 0;
					
					dead <= 0;
					
					score <= 0;
				end
			// Score display
			d1 = score % 10;
			d2 = ((score - (score % 10))/10) % 10;
			d3 = ((score - (score % 100))/100) % 100;
			d4 = ((score - (score % 1000))/1000) % 1000;
		end  // always
						

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// color output assignments
	// only output the colors if the counters are within the adressable video time constraints
	assign o_red = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_red : 4'h0;
	assign o_blue = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_blue : 4'h0;
	assign o_green = (counter_x > 144 && counter_x <= 783 && counter_y > 35 && counter_y <= 514) ? r_green : 4'h0;
	// end color output assignments
	
endmodule  // VGA_image_gen
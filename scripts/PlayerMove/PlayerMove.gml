///@desc Move the player
function PlayerMove() {

	var move         = _right - _left;
	dir              = (move != 0) ? sign(move) : dir;    // the direction of the player
	xspeed_desired   =  move * walkspeed;		          // the limit if the player`s xspeed

	xspeed = lerp(xspeed, xspeed_desired, acceleration);  // change the player`s real speed

	if (CheckCollisions(x + xspeed * scale, y - 1, oObstacle, row) and !damaged) // if the player bumps into an obstacle, 
	{																             //  deal damage equal to 30% of his health
		var _damage = 10;
	
		damaged      = true;	
		damage_timer = 6*30;
	
		if (!protected)  hp -= _damage;
		else          
		{
			protected = false;
			if (pocket[1] == FORCEFIELD_INUMBER)  pocket[1] = 0;	
		}
	
		ShakeScreen(10, 15);
	}

	if (CheckCollisions(x + xspeed * scale + sign(xspeed), y - 1, oSolidParent, row))  // horizontal collision
	{	
		repeat (abs(xspeed * scale))
		{
			if (CheckCollisions(x + 2 * sign(xspeed), y - 1, oSolidParent, row)) break;
			x += sign(xspeed);
		}

		xspeed = 0;
	
		if (CheckCollisions(x, y - 1, oObstacle, row))
		{
			var _obstacle = instance_place(x, y - 1, oObstacle);
			Assert(_obstacle != noone, "Invalid obstacle!");
		
			if (!escape_direction)  escape_direction = sign(x - _obstacle.x);     // if escape_direction isn`t set yet, 
		    xspeed = walkspeed * escape_direction / 2;	                          // calculate the direction player need to go out of the obstacle
		
		}
	}
	else  
	{
		escape_direction = 0;	
	}


	if (x <= oCamera.right && x + xspeed * scale > oCamera.right)  xspeed = 0;
	x += xspeed * scale;  // Horizontal movement


	jump_counter      = max(0, jump_counter - 1);	        // if this counter is greater than zero, then the player will jump if able
	grounded_counter  = max(0, grounded_counter - 1);       // if this counter is greater than zero, then the player is able to jump

	if (_jump)  jump_counter = 10;  


	if (_up && row > 0 && !changing_row)           // attempting to decrease row
	{
		changing_row = true;
		row_der      = -1;
	
		jump_counter = 10;
	}

	if (_down && row < 2 && !changing_row)         // attempting to increase row
	{
		changing_row = true;
		row_der      = 1;
	
		jump_counter = 10;
	}

	if (grounded_counter > 0 and jump_counter > 0)   // attempting to jump
	{
		if (changing_row && row_der > 0)  yspeed = -jumpspeed / 2;
		else                              yspeed = -jumpspeed;
		jump_counter = 0;
		grounded_counter = 0;
	}

	if (CheckCollisions(x, y + yspeed * scale + 1, oBlock, row)) // vertical collision
	{
		//while (!CheckCollisions(x, y + 1, oBlock, row))  y += 1;
		repeat (abs(yspeed * scale))
		{
			if (CheckCollisions(x, y + 1, oBlock, row))  break;
			y++;
		}
		
		yspeed            =  0;
		grounded_counter  = 10;
		if (jump_counter == 0) changing_row = false;
	}
	else                                                          // vertical movement
	{
		y += yspeed * scale;
		yspeed -= grav;
	
		if (changing_row && !blocked)
		{
			var _saved_scale = image_xscale;                  // save the old scale and
			image_xscale     = dir * GetScale(row + row_der); // set the new one, that is equal to
			image_yscale     = GetScale(row + row_der);       // the scale on a new row
		
			if (!CheckCollisions(x, y, oBlock, row + row_der) && y < oGenerator.ground[row + row_der])  // if the row can be changed, then change it
			{
				row   += row_der;
				scale = GetScale(row);
				depth = - 100 * row - 2;
				changing_row = false;
				jump_counter = 0;
			} 
			else if (yspeed > 0 && !CheckCollisions(x + xspeed * scale, y - sprite_height * scale / 3, oBlock, row + row_der) && y - sprite_height * scale / 3 < oGenerator.ground[row + row_der])
			{ // if the player is up some pixels to be transported to another row
				while (CheckCollisions(x + xspeed * scale, y + 1, oBlock, row + row_der) || y >= oGenerator.ground[row + row_der]) y--;
				row   += row_der;
				scale = GetScale(row);
				depth = - 100 * row - 2;
				changing_row = false;
				yspeed = abs(yspeed);
				jump_counter = 0;
			} 
			else  // Change the scale back
			{
				image_xscale = 	_saved_scale;
				image_yscale = abs(_saved_scale);
			}
		}
	}

	grounded = (grounded_counter > 0);       // grounded flag


}

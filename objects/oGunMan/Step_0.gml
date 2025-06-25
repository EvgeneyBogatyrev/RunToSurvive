/// @description


// Limit bullets
bullets = min(20, bullets);

//Check opponent
if (opponent == undefined || !instance_exists(opponent) || opponent.state == UniversalStates.DEAD)
{
	opponent = select_new_player();	
	
	drone.remove_player(opponent); 
	
	
	if (opponent == undefined)
	{
		state = UniversalStates.VICTORY;	
	}
	else
	{
		opponent.state = PlayerStates.NORMAL;	
		opponent.row = 0;
		opponent.x = charging_station.x;
		opponent.y = -10;
		opponent.scale = GetScale(opponent.row);
	}
}
		

switch (state)
{
	case UniversalStates.INTRO:
		//scale = GetScale(row);
		if (!area_created && abs(x - oCamera.x) < 1400)
		{
			area_created = true;
			CreateConstruct(x - 800, 0, _charge_tower_shape);			
			CreateConstruct(x - 400, 1, _middle);
		}
		
		if (!area_updated && abs(x - oCamera.x) < 800)
		{
			area_updated = true;
			CreateConstruct(x - 800, 0, _charge_tower_shape, true);			
		}
		//scale = GetScale(row) * 1.2;
		
		hp = maxhp;
		cum_hp = cum_hp_max;
		
		intro_timer--;
		if (intro_timer <= 0 && oRoomControl.roomspeed == 0)
		{
			state = GunManStates.FIGHT;
		}
		
		if (x < oCamera.right - 100 && oRoomControl.roomspeed != 0)
		{
			StopRoom();
			drone = Create(x, y - 250, oGunManDrone, 0);
			follow_object = Create(oCamera.x, oGenerator.ground[1], oFollow, 0);
			with (oCamera) follow = other.follow_object;
			
			for (var i = 0; i < instance_number(oPlayer); ++i)
			{
				var _player = instance_find(oPlayer, i);
				if (_player.state != UniversalStates.DEAD && _player != opponent)
				{
					_player.state = PlayerStates.TRAPPED;
					_player.x = oCamera.right + 600;
					_player.y = 10;
					_player.row = 0;
					//_player.scale = GetScale(_player.row);
					array_push(drone.stored_players, _player);
				}
				//else if (_player == opponent)
				//{
				//	_drone.stored_player = opponent;
				//}
			}	
		}
		desired_row = 0;
		desired_x_position = x;
		
		break;
	
	case GunManStates.FIGHT:
		// Follow player
		desired_row = opponent.row;
		if (abs(opponent.x - oCamera.left) < abs(opponent.x - oCamera.right))
		{
			desired_x_position = oCamera.right - 150;	
		}
		else
		{
			desired_x_position = oCamera.left + 150;
		}
	
		if (grounded_counter == 10 && row == opponent.row && abs(y - opponent.y) > 120)
		{
			if (row != 0)
			{
				jump_counter = 10;	
			}
		}

		if (row == opponent.row && abs(y - opponent.y) < 75)
		{
			var _solid = false;
			for (var i = x; abs(i - opponent.x) > 10; i += 20 * sign(opponent.x - x))
			{
				if (CheckCollisions(i, y - 10, oSolidParent, row))
				{
					_solid = true;
					break;
				}
			}
			if (_solid)
			{
				if (row == 1)
				{
					jump_counter = 10;
					gun.shoot = true;
				}
			}
			else
			{
				gun.shoot = true;
			}
		}
		break;
		
	case GunManStates.RECHARGE:
		if (row == 0)
		{
			desired_x_position = charging_station.x;
			desired_row = 0;
		}
		else
		{
			desired_row = 0;
			if (abs(opponent.x - oCamera.left) < abs(opponent.x - oCamera.right))
			{
				desired_x_position = oCamera.right - 150;	
			}
			else
			{
				desired_x_position = oCamera.left + 150;
			}
		}
		break;
		
	case GunManStates.FLEE:
		var _rows = [0, 1, 2];
		while (desired_row == opponent.row)
		{
			desired_row = _rows[random_range(0, 3)];
		}
		if (abs(opponent.x - oCamera.left) < abs(opponent.x - oCamera.right))
		{
			desired_x_position = oCamera.right - 150;	
		}
		else
		{
			desired_x_position = oCamera.left + 150;
		}
		break;
	
	case UniversalStates.DEAD:
		with (oPlayer)
		{
			if (state == PlayerStates.TRAPPED)
			{
				state = PlayerStates.NORMAL;	
				row = 0;
				x = other.charging_station.x + random_range(-20, 20);
				y = -10;
				scale = GetScale(row);
			}
		}
		with (oCamera)	follow = oPlayer;
		if (instance_exists(follow_object))
		{
			instance_destroy(follow_object);
		}
		global.score += 100;
		oRoomControl.gamestate = GameState.LOOT;
		GetStandartRoomProperties();
		
		var _counter = 0;
		for (var i = 0; i < 4; ++i)
		{
			var _amount = (i > 1) ? 2 : 1;
			repeat (_amount)
			{
				var _part = Create(x, y - sprite_height * scale, oRoboPart, row);
				with (_part)
				{
					image_index = i;
					depth -= 3;
				
					var _angle = random_range(0, 180);
					if (i == 0)  _angle = 90;
					xspeed = other.explotion_speed * dcos(_angle);
					yspeed = -other.explotion_speed * dsin(_angle);
				
					if (_counter == 3 || _counter == 5)  image_xscale = -image_xscale;
				}
				body_parts[_counter++] = _part;
			}
		}
		
		
		instance_destroy();			
		break;
	
	case UniversalStates.VICTORY:
		desired_row = 0;
		desired_x_position = oCamera.x;
		break;
	
	default:
		Raise("Wrong Gun man state\n");
		break;
}


// Reload charging station
if (instance_exists(charging_station) && charging_station.image_index != 0) 
{
	charge_reload_timer--;
}
if (charge_reload_timer <= 0)
{
	charge_reload_timer = charge_reload_timer_max;
	if (instance_exists(charging_station))
	{
		charging_station.image_index = 0;
	}
}

// Move

if (state != UniversalStates.DEAD && state != UniversalStates.INTRO && state != UniversalStates.VICTORY)
{
	#region state change
	if (charging_station.image_index == 0 && bullets <= 10)
	{
		if (next_state != GunManStates.RECHARGE)
		{
			next_state = GunManStates.RECHARGE;
			state_change_timer = state_change_timer_max / 10;
		}
	}
	else if (opponent.damaged || bullets <= 3)
	{
		if (next_state != GunManStates.FLEE)
		{
			next_state = GunManStates.FLEE;
			state_change_timer = state_change_timer_max;
			if (state == GunManStates.RECHARGE)
			{
				state_change_timer = 10;	
			}
		}
	}
	else
	{
		if (next_state != GunManStates.FIGHT)
		{
			next_state = GunManStates.FIGHT;
			state_change_timer = state_change_timer_max;
			if (state == GunManStates.RECHARGE)
			{
				state_change_timer = 10;	
			}
		}
	}

	state_change_timer--;
	if (state_change_timer == 0)
	{
		state = next_state;	
	}
	
	
	if (hp <= hp_limit)
	{
		if (hp_state == GunManHpState.FIRST)
		{
			with (Create(oCamera.right + 1750, oGenerator.ground[0] - 10, oTumble, 0))  depth -= 2;
			hp_state = GunManHpState.SECOND;
			//maxhp = second_hp;
			//hp = maxhp;
			//cum_hp = second_hp + third_hp;
			hp_limit = third_hp;
		}
		else if (hp_state == GunManHpState.SECOND)
		{
			gun.current_gun = Gun.SHOTGUN;
			pocket[0] = SHOTGUN_INUMBER;
			hp_state = GunManHpState.THIRD;	
			//maxhp = third_hp;
			//hp = maxhp;
			//cum_hp = third_hp;
			hp_limit = 0;
		}
		else
		{
			state = UniversalStates.DEAD;
			with (oTumble)
			{
				instance_destroy();	
			}
			exit;
		}
	}

}
#endregion

if (state != UniversalStates.DEAD && x < oCamera.right)
{
	#region move
	if (abs(desired_x_position - x) < 30)
	{
		move = 0;	
	}
	else
	{
		move = sign(desired_x_position - x);
	}

	var _up = desired_row < row;
	var _down = desired_row > row;
	
	if (random_range(0, 100) > 5)
	{
		_up = false;
		_down = false;
	}

	// the direction of the player
	var xspeed_desired   =  move * walkspeed;		          // the limit if the player`s xspeed

	xspeed = lerp(xspeed, xspeed_desired, 1);  // change the player`s real speed


	if (CheckCollisions(x + xspeed * scale, y - 1, oSolidParent, row)) // if the player bumps into an obstacle, 
	{																           
		// jump
		jump_counter = 10;
	}


	if (CheckCollisions(x + xspeed * scale + sign(xspeed), y - 1, oSolidParent, row))  // horizontal collision
	{	
		repeat (abs(xspeed * scale))
		{
			if (CheckCollisions(x + 2 * sign(xspeed), y - 1, oSolidParent, row)) break;
			x += sign(xspeed);
		}

		xspeed = 0;
	}


	if (x <= oCamera.right && x + xspeed * scale > oCamera.right)  xspeed = 0;

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

	if (yspeed >= 0 && CheckCollisions(x, y + yspeed * scale + sign(yspeed), oBlock, row)) // vertical collision
	{
		repeat (abs(yspeed * scale))
		{
			if (CheckCollisions(x, y + sign(yspeed), oBlock, row))  break;
			y += sign(yspeed);
		}
		yspeed            =  0;
		grounded_counter  = 10;
		if (jump_counter == 0) changing_row = false;
	}
	else                                                          // vertical movement
	{
		yspeed -= grav;
	
		if (changing_row)
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
				depth = - 100 * row - 2
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
	
#endregion
}


event_inherited();

if (state != UniversalStates.INTRO)
{
	scale = GetScale(row) * 1.2;
}

PlayerSprite();

if (opponent != undefined)
{
	dir = (move != 0) ? sign(move) : sign(opponent.x - x);  
	if (row == opponent.row)		dir = sign(opponent.x - x)
}
else
{
	dir = (move != 0) ? sign(move) : dir;  
}
image_xscale = sign(dir) * abs(image_xscale)

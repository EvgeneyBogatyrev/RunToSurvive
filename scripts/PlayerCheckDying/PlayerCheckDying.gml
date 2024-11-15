///@desc Check if player`s lost
function PlayerCheckDying() {

	if (state != UniversalStates.DEAD && x < oCamera.left - CAMERA_BOUNDS) 
	{ 
		state = UniversalStates.DEAD;
		if (global.multiplayer) 
		{
			with (Create(oCamera.right + 200, oCamera.y - 100, oEssence, row))
			{
					depth -= 2;
					player_ind = other.player_index;
					inventory = other.inventory;
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.pocket[0];					
					players_powerup = other.pocket[1];

			}
			
			for (var j = 0; j < revival_number; ++j)
			{
				with (Create(x + sprite_get_width(sEssence) * (j + 1), y, oEssence, row))
				{
					depth -= 2;
					player_ind = other.revival[j];
					inventory = other.revival_inventory[j];
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.revival_guns[j];					
					players_powerup = other.revival_powerups[j];
				}
			}
		}
		
		if (instance_number(object_index) <= 1)  LevelEnd();
		
		instance_destroy();
	} 

	if (hp <= 0 && state != UniversalStates.DEAD) 
	{ 
		state = UniversalStates.DEAD; 
		
		/*
		if (name == "Robo")
		{
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
				
						if (i == 0)  player_ind = other.player_index;
						else         player_ind = noone;
				
						var _angle = random_range(0, 180);
						if (i == 0)  _angle = 90;
						xspeed = other.explotion_speed * dcos(_angle);
						yspeed = -other.explotion_speed * dsin(_angle);
				
						if (_counter == 3 || _counter == 5)  image_xscale = -image_xscale;
					}
					body_parts[_counter++] = _part;
				}
			}
		}
		else
		{*/
		    sprite_index = character.sprites.die; 
		    
			image_speed = 0;
			image_index = 0;
			
			if (global.multiplayer) 
			{
				with (Create(x, y, oEssence, row))
				{
					depth -= 2;
					player_ind = other.player_index;
					inventory = other.inventory;
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.pocket[0];					
					players_powerup = other.pocket[1];
				}
			}
		//}
	
		if (global.multiplayer)
		{
			for (var j = 0; j < revival_number; ++j)
			{
				with (Create(x + sprite_get_width(sEssence) * (j + 1), y, oEssence, row))
				{
					depth -= 2;
					player_ind = other.revival[j];
					inventory = other.revival_inventory[j];
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.revival_guns[j];					
					players_powerup = other.revival_powerups[j];
				}
			}	
		}
	
		instance_destroy(gun); 
		instance_destroy(hands); 
		if (instance_number(object_index) <= 1) 
		{ 
			oCamera.follow = id; 
			oCamera.focus = CameraFocus.TARGET_ZOOM; 
		} 
	}


}

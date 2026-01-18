event_inherited();


switch (state)
{
	case GunManDroneStates.FLY_DOWN:
		image_index = 0;
		y += fly_speed;
		if (y >= y_position)
		{
			state = GunManDroneStates.CATCH_PLAYERS;	
		}
		break;
	
	case GunManDroneStates.CATCH_PLAYERS:
		GetScale(0);
		depth -= 10;
		image_index = 1;
		y = y_position;
		max_arm_length += arm_length_increase;
		break;
		
	case GunManDroneStates.PULL_PLAYERS:
		GetScale(0);
		depth -= 19;
		y = y_position;
		
		var _change_state = pull_players(true);
	
		if (_change_state)
		{
			state = GunManDroneStates.FLY_UP;	
		}
		
		break;
		
	case GunManDroneStates.FLY_UP:
		pull_players(false);
		image_index = 0;
		
		row = 0;
		x = lerp(x, fly_position_x, 0.1);		
		y = lerp(y, fly_position_y, 0.1);

		if (point_distance(x, y, fly_position_x, fly_position_y) < 10)
		{
			if (instance_exists(oGunMan))
			{
				oGunMan.drone = Create(x, y, oGunManDrone, 0);
				
				for (var _i = 0; _i < instance_number(oPlayer); ++_i)
				{
					var _player_object = instance_find(oPlayer, _i);
					if (instance_exists(_player_object)
						&& _player_object.state != UniversalStates.DEAD
						&& _player_object != player_not_to_catch)
					{
						_player_object.x = oCamera.right + 300;
						_player_object.y = -10;
						
						array_push(oGunMan.drone.stored_players, _player_object);
					}
				}
			}
			
			instance_destroy();
		}
		
		
		
		break;
}



// Destroy out of screen
if (x < oCamera.left - CAMERA_OFFSET)
{
	instance_destroy();	
}
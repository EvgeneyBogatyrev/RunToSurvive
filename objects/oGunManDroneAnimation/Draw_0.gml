image_xscale = 0.25;
image_yscale = 0.25;

draw_self();

// Draw arms to each player
if (state != GunManDroneStates.FLY_UP)
{
	var _change_state = true;
	var _player_count = instance_number(oPlayer);
	for (var _i = 0; _i < _player_count; ++_i)
	{
		var _player_object = instance_find(oPlayer, _i);
		if (instance_exists(_player_object)
			&& _player_object.state != UniversalStates.DEAD
			&& _player_object != player_not_to_catch)
		{
			var _distance_to_player = point_distance(x, y, _player_object.x, _player_object.y);
			var _line_length = min(_distance_to_player, max_arm_length);
		
			var _direction = point_direction(x, y, _player_object.x, _player_object.y);
			var _line_end_x = x + lengthdir_x(_line_length, _direction);
			var _line_end_y = y + lengthdir_y(_line_length, _direction);
			draw_line_width(x, y, _line_end_x, _line_end_y, 3);
			
			if (_line_length == _distance_to_player)
			{
				_player_object.state = PlayerStates.TRAPPED;
				_player_object.row = 0;
				_player_object.scale = GetScale(0);
			}
			else
			{
				_change_state = false;	
			}
		}
	}
	
	if (_change_state)
	{
		state = GunManDroneStates.PULL_PLAYERS;	
	}
}

event_inherited();
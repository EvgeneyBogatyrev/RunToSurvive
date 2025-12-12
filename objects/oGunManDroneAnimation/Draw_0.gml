draw_self();


// Animation variables
_wave_speed = 0.1;  // Speed of wave animation
_wave_frequency = 0.1;  // How many waves per tentacle
_wave_amplitude = 10;  // How much the tentacle wobbles

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
			
			// Draw animated tentacle with wave effect
			DrawWavyTentacle(x, y, _direction, _line_length, _i, _distance_to_player);
			
			if (_line_length == _distance_to_player)
			{
				_player_object.state = PlayerStates.TRAPPED;
				_player_object.row = 0;
				_player_object.scale = GetScale(0);
				
				// Add visual effect when player gets caught
				DrawGrabEffect(_player_object.x, _player_object.y);
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
else
{
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
			
			// Draw animated tentacle with wave effect
			DrawWavyTentacle(x, y, _direction, _line_length, _i, _distance_to_player);
			
			if (_line_length == _distance_to_player)
			{
				_player_object.state = PlayerStates.TRAPPED;
				_player_object.row = 0;
				_player_object.scale = GetScale(0);
				
				// Add visual effect when player gets caught
				DrawGrabEffect(_player_object.x, _player_object.y);
			}
		}
	}
}

event_inherited();

// Helper function for wavy tentacle drawing
function DrawWavyTentacle(_start_x, _start_y, _direction, _length, _tentacle_index, _distance_to_player)
{
	draw_set_colour(c_dkgray);
	// Calculate segment count based on length
	var _segment_count = max(floor(_length / 4), 8);
	var _segment_length = _length / _segment_count;
	
	// Animation time for wave effect
	var _time = current_time * 0.001;
	
	// Color for tentacle (can be customized)
	var _tentacle_color = c_red;
	var _tip_color = c_maroon;
	
	// Draw tentacle segments
	var _prev_x = _start_x;
	var _prev_y = _start_y;
	
	for (var _seg = 1; _seg <= _segment_count; _seg++)
	{
		var _seg_progress = _seg / _segment_count;
		var _current_length = _seg_progress * _length;
		
		// Calculate wave offset perpendicular to direction
		var _wave_offset = sin(_time * _wave_speed + _tentacle_index * 2 + _seg * _wave_frequency) * _wave_amplitude * _seg_progress;
		
		// Current point with wave effect
		var _current_x = _start_x + lengthdir_x(_current_length, _direction) + lengthdir_x(_wave_offset, _direction + 90);
		var _current_y = _start_y + lengthdir_y(_current_length, _direction) + lengthdir_y(_wave_offset, _direction + 90);
		
		// Line thickness tapers toward the end
		var _line_width = lerp(6, 2, _seg_progress);
		
		// Draw segment
		draw_line_width(_prev_x, _prev_y, _current_x, _current_y, _line_width);
		
		// Draw a circle at joints for a smoother look
		if (_seg < _segment_count)
		{
			draw_circle(_current_x, _current_y, _line_width / 3, false);
		}
		
		_prev_x = _current_x;
		_prev_y = _current_y;
	}
	
	// Draw a "hand" at the end when reaching player
	if (_length == _distance_to_player)
	{
		// Draw grabbing effect
		draw_circle(_prev_x, _prev_y, 8, false);
		draw_circle(_prev_x, _prev_y, 6, false);
		draw_circle(_prev_x, _prev_y, 4, false);
	}
	
	draw_set_color(c_white);
}

// Visual effect when player gets grabbed
function DrawGrabEffect(_x, _y)
{
	// Draw a flash effect
	draw_set_alpha(0.0);
	//draw_set_color(c_yellow);
	draw_circle(_x, _y - 10, 20, false);
	draw_set_alpha(1);
	//draw_set_color(c_white);
}
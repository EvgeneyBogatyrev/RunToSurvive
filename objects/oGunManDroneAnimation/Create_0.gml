event_inherited();

enum GunManDroneStates
{
	FLY_DOWN,
	CATCH_PLAYERS,
	PULL_PLAYERS,
	FLY_UP,
};

state = GunManDroneStates.FLY_DOWN;

// For flying down from the sky
y_position = 250;
fly_speed = 4;

// Who is the first opponent
player_not_to_catch = undefined;

// Catching players
max_arm_length = 0;
arm_length_increase = 10;

// Pulling players
pull_speed = 0.1;
close_distance = 150;


pull_players = function()
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
				
			_player_object.x = lerp(_player_object.x, x + 100, pull_speed);
			_player_object.y = lerp(_player_object.y, y + 100, pull_speed);
			
			if (_distance_to_player >= close_distance)
			{
				_change_state = false;	
			}
		}
	}	
	return _change_state;
}


// where to fly in the end
fly_position_x = 0;
fly_position_y = 0;


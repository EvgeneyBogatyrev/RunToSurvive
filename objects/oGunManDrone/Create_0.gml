stored_players = [];

remove_player = function(player_id) {
	var _new_stored_players = [];
	for (var _i = 0; _i < len(stored_players); ++_i)
	{
		if (stored_players[_i] != player_id)
		{
			array_push(_new_stored_players, stored_players[_i]);
		}
	}
	stored_players = _new_stored_players;
}

stomping_the_ground = false;
optimal_height = ystart - 50;

stomp_the_ground = function(timer) {
	var _swinganim = animcurve_get(DroneStomp);
	y = ystart - 50 * animcurve_channel_evaluate(_swinganim.channels[0], timer);	
	stomping_the_ground = true;
}
	
event_inherited();

hp = 0;
event_inherited();

oRoomControl.gamestate = GameState.LOOT;
ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 1, 1, 1]);


stand_count = 4; // Number of item stands
stand_spacing = 240; // Pixels between stands
item_stands = array_create(stand_count); // Array to hold stand instances
created_reward = false;


player2reward = ds_map_create();
player_keys = [];
for (var i = 0; i < instance_number(oPlayer); ++i)
{
	var _player_id = instance_find(oPlayer, i);
	player2reward[_player_id] = false;
	array_push(player_keys, _player_id);
}

function can_player_get_reward(_player_id)
{
	return !player2reward[_player_id];
}

function all_done()
{
	for (var i = 0; i < len(player_keys); ++i)
	{
		if (!instance_exists(player_keys[i]))
		{
			continue;	
		}
		if (!player2reward[player_keys[i]])
		{
			return false;	
		}
	}
	return true;
}
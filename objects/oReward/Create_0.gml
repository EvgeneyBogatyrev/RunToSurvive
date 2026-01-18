event_inherited();

oRoomControl.gamestate = GameState.LOOT;
ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 1, 1, 1]);


stand_count = max(3, number_of_players); // Number of item stands
stand_spacing = 540; // Pixels between stands
if (stand_count == 4)
{
	index_shift = 1.5;	
}
else
{
	index_shift = 1;	
}
item_stands = array_create(stand_count); // Array to hold stand instances
created_reward = false;

stopped_room = false;


need_to_update_players = false;

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
	return stopped_room && !player2reward[_player_id];
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
if (need_to_update_players)
{
	for (var i = 0; i < instance_number(oPlayer); ++i)
	{
		var _player_id = instance_find(oPlayer, i);
		if (!array_contains(player2reward, _player_id)) 
			player2reward[_player_id] = false;
			array_push(player_keys, _player_id);
	}
	need_to_update_players = false;	
}
image_xscale = 0.25;
image_yscale = 0.25;

for (var player_idx = 0; player_idx < len(stored_players); ++player_idx)
{
	var stored_player = stored_players[player_idx];
	if (stored_player != noone && instance_exists(stored_player))
	{
		// Draw player
		draw_sprite_ext(stored_player.sprite_index, stored_player.image_index, x, y + 100, stored_player.dir * stored_player.scale, stored_player.scale, 0, c_white, 1);	
	
		var _gunx, _guny;
		switch (stored_player.gun.current_gun)
		{
			case Gun.ROCKET_LAUNCHER:
				_gunx = x;
				_guny = y + 100 - 34 * stored_player.scale;
				break;
	
			default:
				_gunx = x;
				_guny = y + 100 - 22 * stored_player.scale;
				break;
		}
	
		// Draw gun
		draw_sprite_ext(stored_player.gun.sprite_index, 0, _gunx, _guny, stored_player.dir * stored_player.scale, stored_player.scale, 0, c_white, 1);
	
	}
}

draw_self();


event_inherited();
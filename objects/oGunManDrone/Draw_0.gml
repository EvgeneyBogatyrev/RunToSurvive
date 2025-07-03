image_xscale = 0.25;
image_yscale = 0.25;

for (var player_idx = 0; player_idx < len(stored_players); ++player_idx)
{
	var xshift = 0;
	if (player_idx == 1)
	{
		xshift = -10;	
	}
	else if (player_idx == 2)
	{
		xshift = 10;	
	}
	var stored_player = stored_players[player_idx];
	if (stored_player != noone && instance_exists(stored_player))
	{
		// Draw player
		draw_sprite_ext(stored_player.sprite_index, stored_player.image_index, x + xshift + player_position_shift * dsin(image_angle), y + player_position_shift * dcos(image_angle), stored_player.dir * stored_player.scale, stored_player.scale, image_angle, c_white, 1);	
	
		var _gunx, _guny;
		switch (stored_player.gun.current_gun)
		{
			case Gun.ROCKET_LAUNCHER:
				var _gun_shift = 100 - 34 * stored_player.scale;
				_gunx = x + _gun_shift * dsin(image_angle);
				_guny = y +_gun_shift * dcos(image_angle);
				break;
	
			default:
				var _gun_shift = 100 - 22 * stored_player.scale;
				_gunx = x + _gun_shift * dsin(image_angle);
				_guny = y +_gun_shift * dcos(image_angle);
				break;
		}
	
		// Draw gun
		draw_sprite_ext(stored_player.gun.sprite_index, 0, _gunx + xshift, _guny, stored_player.dir * stored_player.scale, stored_player.scale, image_angle, c_white, 1);
	
	}
}

draw_self();


event_inherited();
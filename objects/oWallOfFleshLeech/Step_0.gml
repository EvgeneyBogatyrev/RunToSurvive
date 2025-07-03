var _add_y;
if (hp > 0)
{
	_add_y = 0;
	var _chosen_player = undefined;

	for (var _i = 0; _i < instance_number(oPlayer); _i++)
	{
		var _player = instance_find(oPlayer, _i);
		if _player == noone continue;
		if _player.state == UniversalStates.DEAD continue;
		if _player.row != row continue;
	
		if ((_chosen_player == undefined || _chosen_player.x > _player.x) && _player.x > x - 4 * walkspeed)
		{
			_chosen_player = _player;	
		}
	}

	if (_chosen_player != undefined)
	{
		_add_y = (_chosen_player.y - 30 - y) * 0.2;
	}
	else
	{
		_add_y = (oGenerator.ground[row] - y) * 0.1;
	}
}
else
{
	_add_y = 0;
}

xspeed = walkspeed;
yspeed = magnitude * -cos((get_timer() - start_time) * timescale) + _add_y;


// Inherit the parent event
event_inherited();

if (hp > 0)
{
	//Damage player
	for (var _player_number = 0; _player_number < instance_number(oPlayer); ++_player_number)
	{
		var _player = instance_find(oPlayer, _player_number);
		if (_player.row != row)
		{
			continue;	
		}
		var _masks = collision_detector();
		for (var _mask_index = 0; _mask_index < len(_masks); ++_mask_index)
		{
			var _x = _masks[_mask_index][0];
			var _y = _masks[_mask_index][1];
			var spr = _masks[_mask_index][2];
			
			var spr_width = sprite_get_width(spr);
			var spr_height = sprite_get_height(spr);
			
    
			// Define the collision rectangle for the current entity
			var rect_left = _x - spr_width / 2;
			var rect_top = _y - spr_height / 2;
			var rect_right = _x + spr_width / 2;
			var rect_bottom = _y + spr_height / 2;
		
			if (_player.bbox_right > rect_left && _player.bbox_left < rect_right && _player.bbox_bottom > rect_top && _player.bbox_top < rect_bottom)
			{
				DamageSpecificPlayer(_player, damage);
				break;
			}
		}
	}
}

if (x > oCamera.right + 3 * CAMERA_BOUNDS)
{
	instance_destroy();
}

if (hp <= 0)
{
	if (normal_move)
	{
		oDifficultyController.minions_defeated += 1;
		global.score += 5;
		normal_move = false;
		for (var _i = 0; _i < len(random_velocities); ++_i)
		{
			random_velocities[_i].x = random_range(-3, 3);			
			random_velocities[_i].y = random_range(-3, 3);			
		}
	}
	real_image_alpha -= 0.03;
	if (real_image_aplha <= 0)
		instance_destroy();	
}

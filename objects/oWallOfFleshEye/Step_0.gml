if (instance_exists(oWallOfFleshMouth))
{
	if row = 0
	{
		x = lerp(x, oWallOfFleshMouth.x + 64, 0.1);	
	}
	else
	{
		x = lerp(x, oWallOfFleshMouth.x - 32, 0.1);
	}
}

var sees_player = false;
var target_player = noone;

for (var player_idx = 0; player_idx < instance_number(oPlayer); ++player_idx)
{
	var cur_player = instance_find(oPlayer, player_idx);
	with(cur_player)
	{
		if (row == other.row)
		{
			var _diff = angle_difference(other.image_angle, point_direction(other.x, other.y, x - xspeed, y - sprite_height / 2 * scale));
			other.image_angle -= _diff * 0.2;
			sees_player = true;
		}
	}
	
	if (sees_player)
	{
		target_player = cur_player;
		break;	
	}
}



if (!sees_player)
{
	var _diff = angle_difference(other.image_angle, 0);
	other.image_angle -= _diff * 0.2;
}

// Shoot the player
shoot_timer--;
if (shoot_timer <= 0  && instance_exists(oWallOfFleshController) && oWallOfFleshController.state == WallOfFleshStates.BATTLE)
{	
	
	if (sees_player)
	{
		with (target_player)
		{
			if (row == other.row)
			{
				var _player_x = x;			
				var _player_y = y;
				var _player_sprite_height = sprite_height;
				var _player_scale = scale;
				var _player_xspeed = xspeed;
				var _eye_x = other.x;
				var _eye_y = other.y;

				with (Create(_eye_x, _eye_y, oWallOfFleshBullet, row))
				{
					var direction_to_shoot = point_direction(_eye_x, _eye_y, _player_x - _player_xspeed, _player_y - _player_sprite_height / 2 * _player_scale);
					Print(direction_to_shoot);
					xspeed = lengthdir_x(15, direction_to_shoot);	
					yspeed = lengthdir_y(15, direction_to_shoot);
					depth = GetScale(other.row) - 2;
				}
			}
		}
	}
	shoot_timer = shoot_timer_max * (0.1 + controller.hp / controller.maxhp);
}

// Redirect the damage to host
if (hp != prev_hp)
{
	controller.hp -= max(0, prev_hp - hp);	
	controller.cum_hp -= max(0, prev_hp - hp);
	hp = prev_hp;
}

event_inherited();




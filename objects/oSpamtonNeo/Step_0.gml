/// @description Insert description here
// You can write your code in this editor

//y = ystart + sin((get_timer() - phase) / 250000) * magnitude;

switch (state)
{
	case UniversalStates.INTRO:
		draw_x = lerp(draw_x, oCamera.right - CAMERA_BOUNDS / 3, 0.1);
			
		y_to_go = oGenerator.ground[row] - 100 * GetScale(row);
		draw_y = lerp(draw_y, y_to_go, 0.01);
		// draw_y += (y_to_go - draw_y) * 0.01;
			
		hp = maxhp;
		cum_hp = maxhp;
			
		intro_timer--;
		if (intro_timer == 0)
		{
			state = choose(SpamtonStates.PIPIS, SpamtonStates.HEART);	
		}
		
		break;
		
	case SpamtonStates.HEART:
		sprite_index = sSpamtonNEOHeart;
		first_pipis = true;
		ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 1, 1, 0]);
		draw_x = lerp(draw_x, oCamera.right - CAMERA_BOUNDS / 3, 0.1);
		// Changing rows
		change_row_timer--;
		if (change_row_timer <= 0)
		{
			change_row_timer = change_row_timer_max * random_range(0.8, 1.2);
	
			var _old_row = row;
			while (_old_row == row)
				row = choose(0, 1, 2);
	
			y_to_go = oGenerator.ground[row] - 100 * GetScale(row);
			if (_old_row < row)
			{
				scale = GetScale(row, true);
				depth -= 2;
			}
			else
			{
				scale = GetScale(row);
			}
		}


		draw_y = lerp(draw_y, y_to_go, 0.1);
		if (abs(draw_y - y_to_go) < 3)
		{
			scale = GetScale(row, true);
			depth -= 2;
		}
		
		// Heart
		if (heart_length <= heart_length_min)
		{
			var _old_angle = heart_angle;
			while (abs(_old_angle - heart_angle) < 30)
				heart_angle = irandom_range(heart_angle_min, heart_angle_max);
			increase_length = true;
		}
		
		if (increase_length)
		{
			heart_length = lerp(heart_length, heart_length_max, 0.2);
		}
		else
		{
			heart_length -= 2.5;	
		}
		
		if (heart_length >= heart_length_max - 10)
		{
			increase_length = false;
			for (var i = 0; i < 10; ++i)
			{
				var _angle;
				if (heart_angle > 180)
				{
					_angle = irandom_range(heart_angle_min, heart_angle);
				}
				else
				{
					_angle = irandom_range(heart_angle, heart_angle_max);
				}
				
				
				with (Create(draw_x + lengthdir_x(heart_length, heart_angle), draw_y + lengthdir_y(heart_length, heart_angle), oSpamtonShard, row))
				{
					xspeed = lengthdir_x(10, _angle);					
					yspeed = lengthdir_y(10, _angle);	
					image_angle = _angle;
				}
			}
		}
		
		if (prev_hp > hp)
		{
			heart_hp -= (prev_hp - hp);
			
			Print(heart_hp);
			
			if (heart_hp <= 0)
			{
				state = SpamtonStates.PIPIS;
			}
			
			hp = prev_hp;
			cum_hp = prev_hp;
		}	
		
		break;
		
	case SpamtonStates.PIPIS:
		sprite_index = sDelverCasting;
		ds_map_replace(oRoomControl.room_properties, "ForbiddenObstacles", [0, 1, 1, 0, 1, 0]);
		draw_x = lerp(draw_x, oCamera.right - CAMERA_BOUNDS / 3, 0.1);
		
		change_row_timer--;
		if (change_row_timer <= 0)
		{
			change_row_timer = change_row_timer_max * random_range(0.8, 1.2);
	
			var _old_row = row;
			while (_old_row == row)
				row = choose(0, 1, 2);
	
			y_to_go = oGenerator.ground[row] - 100 * GetScale(row);
			if (_old_row < row)
			{
				scale = GetScale(row, true);
				depth -= 2;
			}
			else
			{
				scale = GetScale(row);
			}
		}


		draw_y = lerp(draw_y, y_to_go, 0.1);
		if (abs(draw_y - y_to_go) < 3)
		{
			scale = GetScale(row, true);
			depth -= 2;
		}
		
		gun_rotation += gun_rotation_add;
		if (gun_rotation >= gun_rotation_max || gun_rotation <= gun_rotation_min)
		{
			gun_rotation_add *= -1;	
		}
		
		pipis_shot_timer--;
		if (pipis_shot_timer <= 0)
		{
			pipis_shot_timer = pipis_shot_timer_max;
			
			var _pipis_row = row;
			with (Create(arm_right_x + lengthdir_x(arm_len * scale, gun_rotation - 90), arm_right_y + lengthdir_y(arm_len * scale, gun_rotation - 90), oSpamtonPipis, _pipis_row))
			{
				xspeed = lengthdir_x(10, other.gun_rotation - 90);				
				yspeed = lengthdir_y(10, other.gun_rotation - 90);
				if (other.first_pipis)
				{
					has_pointer = true;
					other.first_pipis = false;
				}
			}
		}
		
		change_attack_timer--;
		if (change_attack_timer <= 0 && state == SpamtonStates.PIPIS)
		{
			change_attack_timer = change_attack_timer_max * random_range(0.9, 1.5);
			state = SpamtonStates.HEART;
			heart_hp = heart_hp_max;
		}
		
		
		break;
	
	case UniversalStates.DEAD:
		draw_x += oRoomControl.roomspeed * scale;
		if (draw_x < oCamera.left - CAMERA_BOUNDS)
		{
			instance_destroy();	
		}
		y_to_go = -100;
		draw_y = lerp(draw_y, y_to_go, 0.01);
		oRoomControl.gamestate = GameState.LOOT;
		GetStandartRoomProperties();
		instance_destroy();	
		break;
		
}

if (state != SpamtonStates.HEART)
{
	x = draw_x;
	y = draw_y;	
}
else
{
	x = heart_x;
	y = heart_y;
}

if (state == SpamtonStates.HEART || state == SpamtonStates.PIPIS)
{
	miniboss_spawn_timer--;	
	if (miniboss_spawn_timer <= 0)
	{
		miniboss_spawn_timer = miniboss_spawn_timer_max;
		var _row = choose(0, 1, 2);
		with (Create(oCamera.right + CAMERA_BOUNDS, oGenerator.ground[_row], oSpamtonSmall, _row))
		{
			movement_speed = 4;	
			xspeed = -movement_speed;
		}
	}
}


if (hp <= 0 && state != UniversalStates.DEAD)
{
	global.score += 125;
	
	oRoomControl.gamestate = GameState.LOOT;
	//if (loot_profile_id != -1)	oRoomControl.gamestate = GameState.LOOT;
	//else						oRoomControl.gamestate = GameState.NORMAL;
	//GetStandartRoomProperties();
	ShakeScreen(12, 120);
	state = UniversalStates.DEAD;
	with (oSpamtonSmall)
	{
		instance_destroy();	
	}
	with (oSpamtonPipis)
	{
		instance_destroy();	
	}
}

prev_hp = hp;

// Inherit the parent event
event_inherited();


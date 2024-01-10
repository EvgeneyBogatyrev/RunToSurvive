/// @description

switch (state)
{
	case UniversalStates.INTRO:
		y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
		x = lerp(x, oCamera.right - CAMERA_BOUNDS / 3, acceleration);
		xspeed = -0.001;
		
		hp = mage_hp;
		cum_hp = cum_hp_max;
		
		intro_timer--;
		if (intro_timer == 0)
		{
			state = DelverStates.MAGE;	
			attack_timer = 5;
		}
		
		break;
	
	case DelverStates.MAGE:
		
		var _flag = true;
		for (var i = 0;i < instance_number(oPlayer); ++i)
		{
			var _player = instance_find(oPlayer, i);
			if (_player.state != UniversalStates.DEAD)
			{
				_flag = false;
				break;
			}
		}
		
		if (_flag)
		{
			state = DelverStates.VICTORY;
			exit;
		}
	
	
		y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
		x = lerp(x, oCamera.right - CAMERA_BOUNDS / 3, acceleration);
		xspeed = -0.001;
		
		if (sprite_index == sDelverStand)
		{
			attack_timer--;
			if (attack_timer == 0)
			{
				image_index = 0;
				sprite_index = sDelverAttack;
			}
		}
		
		if (sprite_index == sDelverAttack && AnimationEnd())
		{
			with (Create(x - 41 * scale * dir, y - 23 * scale, oDelverZap, row))  
			{
				other.zap = id;
				host = other.id;
				player = instance_find(oPlayer, irandom_range(0, instance_number(oPlayer) - 1));
				if (player == noone)
				{
					instance_destroy();
					exit;	
				}
				xx = player.x;
				rrow = player.row;
			}
			image_index = 0;
			sprite_index = sDelverCasting;
		}
		
		if (sprite_index == sDelverCasting && AnimationEnd())
		{
			if (!instance_exists(zap) || zap == noone)
			{
				image_index = 0;
				sprite_index = sDelverStand;
				attack_timer = floor(attack_timer_max * random_range(0.8, 1.2));
			}
		}
		
		if (hp <= 0)
		{
			state = DelverStates.INSECT;
			image_index = 0;
			sprite_index = sDelverTransform;
			maxhp = insect_hp;
			hp = maxhp;
		}
		
		break;
	
	case DelverStates.INSECT:
	
		if (sprite_index == sDelverTransform)
		{
			y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
			x = lerp(x, oCamera.right - CAMERA_BOUNDS / 3, acceleration);
			xspeed = -0.001;
			cum_hp = insect_hp;
			
			if (AnimationEnd())
			{
				ShakeScreen(10, 60);
				image_index = 0;
				sprite_index = sDelverInsect;
				hp = maxhp;
			}	
		}
		else
		{
			xspeed = 0;
			yspeed = 0;
			if (rest_timer > stop_time)
			{
				player = GetPlayer(PlayerPreferences.LOWEST_HEALTH);
			
				if (player == noone)
				{
					state = DelverStates.VICTORY;	
					exit;
				}
			
				if (player.row != row) 
				{
					desired_row = player.row;
				}
				scale = lerp(scale, GetScale(player.row, false), 0.1);
				y = lerp(y, player.bbox_top, acceleration / 5);
			

				if (row != desired_row)
				{
					
					for (var _row = 0; _row < 3; ++_row)
					{
						if (y < oGenerator.ground[_row] - sprite_height/4)	
						{
							row = _row;
							depth = -100 * row - 2;
							break;
						}
					}
				}
				
				dir_update--;
				if (dir_update <= 0) 
				{
					dir_update = dir_update_max;
					dir = sign(player.x - x);
				}
				
				for (var _row = 0; _row < 3; ++_row)
				{
					if (CheckCollisions(x, oGenerator.ground[_row] - sprite_height/2, player, _row))
					{
						break;
					}
					else
					{
						if (flying_forward || player.x - x > offset * 3) 
						{
							x += insect_speed * abs(player.scale) * dir;
							flying_forward = true;
						}
						else
						{
							x = lerp(x, oCamera.left + CAMERA_BOUNDS / 3, acceleration / 10);
							flying_forward = false;
						}
					}
				}
				
				// Damaging player
				
				var _is_near_player = distance_to_object(player) < player_distance_threshold * scale;
				
				if (!_is_near_player)
				{
					insect_attack_cooldown = 0;
				}
				
				if (insect_attack_cooldown <= 0 && sprite_index != attack_sprite && _is_near_player)
				{
					sprite_index = attack_sprite;
					image_index = 0;
					
					insect_attack_cooldown = insect_attack_cooldown_max;
				}
				else if (sprite_index == attack_sprite && AnimationEnd())
				{
					image_index = 0;
					sprite_index = sDelverInsect;
					visualise_circle = false;
				}
				else if (sprite_index == attack_sprite && image_index >= attack_image_index)
				{
					CircleDamage(slash_damage, 0, x + dir * attack_x_shift * scale, y, attack_radius * scale);
					ShakeScreen(3, 10);
					visualise_circle = true;
				}
				
			}
			else
			{
				sprite_index = sDelverInsect;
				flying_forward = false;
				x = lerp(x, oCamera.right - CAMERA_BOUNDS / 3, acceleration);
				y = lerp(y, ystart, acceleration);
				dir = -1;
				row = 0;
				scale = lerp(scale, GetScale(1, false), 0.1);
			}
			
			rest_timer--;
			if (rest_timer == 0)
			{
				rest_timer = rest_timer_max;	
			}
			
			if (insect_attack_cooldown > 0) insect_attack_cooldown--;
			
			
			if (hp <= 0)
			{
				state = UniversalStates.DEAD;
				sprite_index = sDelverDying;
				image_index = 0;
				
				
				
				ShakeScreen(10, 60);
			}
			
		}
		break;
	
	case UniversalStates.DEAD:
		if (AnimationEnd())
		{
			global.score += 100;
			oRoomControl.gamestate = GameState.LOOT;
			GetStandartRoomProperties();
			instance_destroy();			
		}
		break;
	
	case DelverStates.VICTORY:
		xspeed = insect_speed * scale;
		yspeed = 0;
		break;
	
	default:
		Raise("Wrong Delver state\n");
		break;
}

event_inherited();
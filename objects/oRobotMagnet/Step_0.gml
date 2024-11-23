// Inherit the parent event
event_inherited();


if (host == undefined || !instance_exists(host))
{	
	instance_destroy();
	exit;
}
else
{
	x = host.x + host.magnet_offset_x * scale;
	y = host.y + host.magnet_offset_y * scale;
}


var _desired_angle;


switch (state)
{
	case MagnetStates.INACTIVE:
		_desired_angle = inactive_angle;
		
		if (host.state == UniversalStates.DEAD)
		{
			exit;	
		}
		
		inactive_timer--;
		if (inactive_timer <= 0)
		{
			inactive_timer = inactive_timer_max * random_range(0.8, 1.2);	
			state = MagnetStates.ROTATING;
			player = GetPlayer(PlayerPreferences.NOT_STANDARD_WEAPON);
		}
		
		
		break;
		
	case MagnetStates.ROTATING:
		if (!instance_exists(player))
		{
			_desired_angle = inactive_angle;
			state = MagnetStates.INACTIVE;
			break;
		}
		
		_desired_angle = point_direction(x, y, player.x, player.y);
		if (abs(_desired_angle - image_angle) < angle_threshold)
		{
			// Take the gun
			with (player)
			{	
					
				var _penetrate_index = 0;
				
				last_weapon = pocket[_penetrate_index];
				
				other.cur_replica = Create(gun.x, gun.y, oRobotWeaponReplica, row);
				
				with (other.cur_replica)
				{
					sprite_index = GetGunSprite(GetGunStateFromID(other.last_weapon));
				}
					
				pocket[_penetrate_index] = STDGUN_INUMBER;
				
				if (last_weapon == STDGUN_INUMBER)
				{
					bullets = 0;	
				}
				
					
				if (active_pocket_index == _penetrate_index)
				{
					gun.current_gun = Gun.STANDART_GUN;
					gun.secondary = false;
				}
					
			}
			
			state = MagnetStates.ACTIVE;
			saved_angle = _desired_angle;
		}
		break;
		
	case MagnetStates.ACTIVE:
		if (!instance_exists(player))
		{
			_desired_angle = inactive_angle;
			state = MagnetStates.INACTIVE;
			break;
		}
		
		_desired_angle = point_direction(x, y, player.x, player.y);
		image_angle = _desired_angle;
		
		if (cur_replica != undefined)
		{
			cur_replica.depth = depth - 1;
			cur_replica.x = lerp(cur_replica.x, x + lengthdir_x(gun_point_x * scale, image_angle), 0.1);			
			cur_replica.y = lerp(cur_replica.y, y + lengthdir_y(gun_point_y * scale, image_angle) - 20, 0.1);	
		
			if (place_meeting(x, y, cur_replica))
			{
				cur_replica.image_alpha -= 0.01;
				if (cur_replica.image_alpha <= 0)
				{
					instance_destroy(cur_replica);
					state = MagnetStates.INACTIVE;
				}
			}
			else
			{
				cur_replica.image_angle += 10;	
			}
		}
		break;
}

if (_desired_angle > image_angle) 
{
	_desired_angle -= 360;	
}
if (abs(image_angle - _desired_angle) > 1)
{
	image_angle -= 1;	
}
if (image_angle < 0)
{
	image_angle += 360;	
}

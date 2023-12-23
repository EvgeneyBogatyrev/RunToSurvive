// Inherit the parent event
event_inherited();

switch (state)
{
	case FlyingRobotStates.MOVE:
		xspeed = -walkspeed;
		
		if (x < (oCamera.right + oCamera.left)/2 && attack_timer > 0)
		{
			state = FlyingRobotStates.ATTACK;
			var _player = GetPlayer(PlayerPreferences.LOWEST_HEALTH);
			if (_player != noone)
			{
				row = _player.row;	
			}
			attack_timer = attack_timer_max;
		}
		break;
		
	case FlyingRobotStates.ATTACK:
		x = (oCamera.right + oCamera.left)/2;
		y = lerp(y, oGenerator.ground[row] - 210 * GetScale(row), 0.05);
		scale = lerp(scale, GetScale(row, true), 0.05);
		depth -= 2;
		attack_timer--;
		if (attack_timer <= 0)
		{
			for (var _i = start_angle; _i < 180 - start_angle; _i += (180 - 2 * start_angle) / amount)
			{
				with (Create(x, y, oMissileVertical, row))
				{
					angle = _i;	
				}
			}
			state = FlyingRobotStates.MOVE;
		}
		break;
		
}


if (x < oCamera.left - CAMERA_BOUNDS)
{
	instance_destroy();	
}


ContactDamage(5, 0);
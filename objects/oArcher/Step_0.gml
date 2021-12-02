if (state != UniversalStates.DEAD && state != HalfBossStates.INACTIVE)  image_speed = 1;
event_inherited();

switch (state)
{
	case HalfBossStates.IDLE:
		if (xspeed != 0)    sprite_index = sArcherRun;
		else				sprite_index = sArcherStand; 
		
		if (walk_timer <= 0)
		{
			xspeed = choose(-1, 0, 1) * walkspeed;
			walk_timer = irandom_range(25, 75);
		}
		else  walk_timer--;	
		
		
		if (CheckCollisions(x + xspeed * scale, y, oSolidParent, row))  xspeed *= -1;
		
		action_timer = action_timer_max/2;
		
		break;
		
	case HalfBossStates.TRIGGERED:
		if (sprite_index != sArcherRun)  image_speed = 1.5;
		else							 image_speed = 1;
	
		if (action_timer <= 0)
		{
			if (abs(player.x - x) < 50 * scale)
			{
				xspeed = sign(x - player.x)	* walkspeed;
				sprite_index = sArcherRun;
			} 
			else if (abs(player.x - x) > 500 * scale || x < oCamera.left || x > oCamera.right)
			{
				xspeed = sign(player.x - x)	* (x < oCamera.left ? (oRoomControl.roomspeed + 4) * scale : walkspeed);
				sprite_index = sArcherRun;
			}
			else
			{
				xspeed = 0;
				dir = sign(player.x - x);
				
				if (y - player.y >= BLOCKSIZE * scale)  
				{
					sprite_index = sArcherSuperAttack;
				}
				else  sprite_index = sArcherAttack;	
				
				already_attacked = false;
				
			}
			action_timer = action_timer_max;
		}
		else  action_timer--;
		
		if (CheckCollisions(x + xspeed * scale, y, oSolidParent, row))  xspeed *= -1;
		
		break;
	
	case UniversalStates.DEAD:
		sprite_index = sArcherDying;
		xspeed = 0;		
		break;
	
	
	default:
		break;
}

if (image_index + image_speed >= shoot_index && !already_attacked)  //if its time to shoot
{
	already_attacked = true;
	if (sprite_index == sArcherAttack)	
	{
		with (Create(x + 25 * dir * scale, y - 48 * scale, oArrow, row))
		{
			depth -= 2;
			xspeed = other.arrow_speed * other.dir;
			yspeed = random_range(-0.5, 0.5);
			angled = false;
			host = other.id;
		}	
	}
	else if (sprite_index == sArcherSuperAttack)
	{
		var _angle = 60 - 15 * (choose(1, 2, 3) - 1);
		with (Create(x + 21 * dir * scale, y - 60 * scale, oArrow, row))
		{
			depth -= 2;
			angled = true;
			yspeed = -other.arrow_speed * dsin(_angle + random_range(-5, 5));
			xspeed = other.dir * other.arrow_speed * dcos(_angle + random_range(-5, 5));
			host = other.id;
		}
	}
}

if (AnimationEnd() && (sprite_index == sArcherAttack || sprite_index == sArcherSuperAttack))  sprite_index = sArcherStand;


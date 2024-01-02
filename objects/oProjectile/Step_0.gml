if (sprite_index == sPellet)
{
	image_speed = 0;
	image_index = 0;
}

if (abs(x - oCamera.x) > oCamera.view_w_half * 3)  instance_destroy();

image_angle = point_direction(x, y, x + xspeed, y + yspeed);

if (CheckCollisions(x + xspeed, y + yspeed, oEnemyParent, row))
{
	var _victim = GetCollider(x + xspeed, y + yspeed, oEnemyParent, row);

	if (_victim.state != UniversalStates.DEAD && _victim.state != HalfBossStates.INACTIVE && _victim.hp > 0) 
	{
		_victim.hp -= damage;
		if object_is_ancestor(_victim.object_index, oBossParent)
		{
			_victim.cum_hp -= damage;	
		}
		display = true;
		_victim.hit_flash = 3;
	
		repeat (abs(xspeed))
		{
			if (CheckCollisions(x + sign(xspeed), y + sign(yspeed) * yspeed / xspeed, oEnemyParent, row))	break;	

			x += sign(xspeed);	
			y += sign(yspeed) * yspeed / xspeed
		}
	
		if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
		instance_destroy();	
	}
}

if (CheckCollisions(x + xspeed, y + yspeed, oSolidParent, row) || CheckCollisions(x + xspeed / 2, y + yspeed, oSolidParent, row))
{
	repeat (abs(xspeed))
	{
		if (CheckCollisions(x + sign(xspeed), y + sign(yspeed) * yspeed / xspeed, oSolidParent, row))	break;
		
		x += sign(xspeed);		
		y += sign(yspeed) * yspeed / xspeed;
		
	}

	instance_destroy();
}

if (place_meeting(x + xspeed, y + yspeed, oDelver) && oDelver.state == DelverStates.INSECT)
{
	repeat (abs(xspeed))
	{
		if (place_meeting(x + sign(xspeed), y + sign(yspeed) * yspeed / xspeed, oDelver))  break;
		
		x += sign(xspeed);		
		y += sign(yspeed) * yspeed / xspeed;
		
	}
	oDelver.hp -= damage;
	oDelver.cum_hp -= damage;
	oDelver.hit_flash = 3;
	display = true;
	instance_destroy();	
}


event_inherited();

if (image_index == 1)  image_speed = 0;



///desc
if (!start)
{
	if (CheckCollisions(x, y + (yspeed + sprite_width/2) * scale, oSolidParent, row))
	{
		repeat (abs(yspeed * scale))	
		{
			if (CheckCollisions(x, y + sign(yspeed) + sprite_height/2 * scale, oSolidParent, row))  break;
			y += sign(yspeed);
		}
		yspeed = 0;
		start = true;
		y0 = y - magnitude;
	}
	else
	{
		yspeed -= grav;	
	}
}
else
{
	var _player = GetCollider(x, y, oPlayer, row);
	if (_player != noone && _player.state != UniversalStates.DEAD) 
	{
		with (_player)
		{
			revival[revival_number++] = other.player_id;	
			pocket[revival_number + 1] = ESSENCE_INUMBER;
		}
		instance_destroy();
	}

	y = y0 + magnitude * sin((get_timer() - phase) / 200000) * scale;
}
event_inherited();
///desc
if (times_resurrected >= 5)
{
	y += yspeed;
	yspeed += grav;
	if (y < -100)
	{
		instance_destroy();	
	}
}
else
{


	if (!start)
	{
		if (CheckCollisions(x, y + yspeed, oSolidParent, row))
		{
			repeat (abs(yspeed * scale))	
			{
				if (CheckCollisions(x, y + 1, oSolidParent, row))  break;
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
		if (_player != noone && _player.state != UniversalStates.DEAD && _player.hp > 0) 
		{
			with (_player)
			{
				revival[revival_number] = other.player_ind;
				revival_inventory[revival_number] = other.inventory;
				revival_guns[revival_number] = other.players_gun;				
				revival_powerups[revival_number] = other.players_powerup;

				revival_number += 1;
				//pocket[revival_number + 1] = ESSENCE_INUMBER;
			}
			instance_destroy();
		}

		y = y0 + magnitude * sin((get_timer() - phase) / 200000) * scale;
	}
	if (x < oCamera.left)
	{ 
		x += oCamera.view_w_half * 2;
		repeat (oCamera.view_w_half)
		{
			if (x < oCamera.right)
			{
				x += 5;	
			}
			else
			{
				break;	
			}
		}
		y = oGenerator.ground[row] - 20 * scale;
		start = false;
	}
}
event_inherited();
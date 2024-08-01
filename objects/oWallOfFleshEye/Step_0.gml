// Shoot the player
shoot_timer--;
if (shoot_timer <= 0)
{	
	with (oPlayer)
	{
		if (row == other.row)
		{
			with (Create(other.x, other.y, oShootingRobotBullet, row))
			{
				var direction_to_shoot = point_direction(x - xspeed, y - sprite_height / 2 * scale, other.x, other.y);
				Print(direction_to_shoot);
				xspeed = lengthdir_x(15, direction_to_shoot);	
				yspeed = lengthdir_y(15, direction_to_shoot);
				depth = GetScale(other.row) - 2;
				damage = 0;
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

if row = 0
{
	x = lerp(x, oWallOfFleshMouth.x + 64, 0.1);	
}
else
{
	x = lerp(x, oWallOfFleshMouth.x, 0.1);
}





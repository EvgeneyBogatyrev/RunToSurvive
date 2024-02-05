/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе
ContactDamage(20, 0);

yspeed -= grav;

if (CheckCollisions(x, y + yspeed, oBlock, row))
{
	repeat (abs(yspeed))
	{
		if (CheckCollisions(x, y + sign(yspeed), oBlock, row))
		{
			break;	
		}
		y += sign(yspeed);
	}
	
	yspeed *= -0.8;
	
	if (abs(yspeed) < 5 && x > oCamera.left && x < oCamera.right)
	{
		for (var _angle = 30; _angle < 180; _angle += 30)
		{
			with (Create(x, y, oSpamtonShard, row))
			{
				xspeed = lengthdir_x(10, _angle);					
				yspeed = lengthdir_y(10, _angle);	
				image_angle = _angle;
			}	
		}
		instance_destroy()
	}
}

if (CheckCollisions(x + xspeed, y, oBlock, row))
{
	repeat (abs(xspeed))
	{
		if (CheckCollisions(x + sign(xspeed), y, oBlock, row))
		{
			break;	
		}
		x += sign(xspeed);
	}
	
	xspeed *= -1;
}





// Inherit the parent event
event_inherited();


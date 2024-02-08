/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе
ContactDamage(damage, 0);

yspeed -= grav;

image_angle += 5;

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
				image_angle = _angle <= 90 ? 180 + _angle : _angle;
			}	
		}
		instance_destroy();
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
	
	xspeed *= -0.85;
}

if (hp <= 0)
{
	with (Create(x, y, oItemDrop, row))
	{
		depth -= 2;
		image = choose(BATTERY_INUMBER);
	}
	var _counter = 0;
	for (var i = 0; i < 6; ++i)
	{
		var _amount = 1;
		repeat (_amount)
		{
			var _part = Create(x, y - sprite_height * scale, oRoboPart, row);
			with (_part)
			{
				sprite_index = sPipisChunk;
				image_index = choose(0, 1, 2);
				depth -= 3;
				
				var _angle = random_range(0, 180);
				if (i == 0)  _angle = 90;
				xspeed = 10 * dcos(_angle);
				yspeed = -10 * dsin(_angle);
				
				//if (_counter == 3 || _counter == 5)  image_xscale = -image_xscale;
			}
			//body_parts[_counter++] = _part;
		}
	}
	instance_destroy();
}



// Inherit the parent event
event_inherited();


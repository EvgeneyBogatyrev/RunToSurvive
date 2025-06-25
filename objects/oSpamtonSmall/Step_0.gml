/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if (CheckCollisions(x, y, oBlock, row))
{
	y -= 10;
}

if (CheckCollisions(x + xspeed, y, oBlock, row))
{
	repeat(abs(xspeed))
	{
		if (CheckCollisions(x + sign(xspeed), y, oBlock, row)) break;
		x += sign(xspeed);
	}
	xspeed *= -1;
}

ContactDamage(damage, 0);

if (hp <= 0)
{
	oDifficultyController.minions_defeated += 1;
	global.score += 5;
	with (Create(x, y, oItemDrop, row))
	{
		depth -= 2;
		image = choose(HEARTH_INUMBER);
	}
	
	instance_destroy();	
}

//Gravity
if (!CheckCollisions(x, y + 1, oSolidParent, row) && can_be_knockbacked)
{
	
	if (CheckCollisions(x, y + yspeed * scale, oSolidParent, row))
	{
		repeat (abs(yspeed))
		{
			if (CheckCollisions(x, y + sign(yspeed), oSolidParent, row))
			{
				break;	
			}
			y += sign(yspeed);
		}
		yspeed = 0;
	}
}

// Inherit the parent event
event_inherited();

if (!CheckCollisions(x, y + 1, oSolidParent, row))
{
	yspeed -= grav;

}
else
{
	yspeed = 0;
	knockbacked = false
}


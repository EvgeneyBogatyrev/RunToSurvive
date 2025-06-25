/// @description Insert description here
// You can write your code in this editor

if (hp > 0)
{
	if (sprite_index == sStumpAppear)
	{
		if (AnimationEnd())
		{
			sprite_index = sStumpRun;
			walkspeed = 4;
		}
	}
	else
	{
		x -= walkspeed * scale;
		ContactDamage(damage, 0);
	}
}
else
{
	if (!given)
	{
		oDifficultyController.minions_defeated += 1;
		global.score += 5;
		given = true;
		with (Create(x, y, oItemDrop, row))
		{
			depth -= 2;
			image = choose(HEARTH_INUMBER, BATTERY_INUMBER);
		}
	}
	state = UniversalStates.DEAD;
	sprite_index = sStumpDying;
	if (AnimationEnd())
	{
		image_speed = 0;
	}
	draw_alpha -= 0.01;
	if (draw_alpha <= 0)
	{
		instance_destroy();	
	}
}

//Gravity
if (!CheckCollisions(x, y + 1, oSolidParent, row) && can_be_knockbacked)
{
	//yspeed -= grav;
	
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

image_xscale = -abs(image_xscale);

if (x < oCamera.left - CAMERA_BOUNDS)
{
	instance_destroy();
}
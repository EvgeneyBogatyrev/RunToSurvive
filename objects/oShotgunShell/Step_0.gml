/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


if (CheckCollisions(x + xspeed, y + yspeed, oBlock, row))
{
	repeat (abs(xspeed))
	{
		if (CheckCollisions(x + sign(xspeed), y + sign(yspeed) * yspeed / xspeed, oBlock, row))	break;
		x += sign(xspeed);
		y += sign(yspeed) * yspeed / xspeed;
	}
	xspeed = 0;
	yspeed = 0;
}


// Inherit the parent event
event_inherited();

yspeed -= grav;
if (xspeed != 0)
{
	image_angle += rotation_speed;
}
else
{
	alpha -= 0.01;
	image_alpha = alpha;
	if (image_alpha <= 0)
	{
		instance_destroy();
		exit;
	}
}
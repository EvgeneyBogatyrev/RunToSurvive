event_inherited();

ContactDamage(damage, 0);


image_angle = 180 - angle;

xspeed = spd * dcos(angle);
yspeed = spd * dsin(angle);


if (CheckCollisions(x, y, oBlock, row))
{
	instance_destroy();	
}

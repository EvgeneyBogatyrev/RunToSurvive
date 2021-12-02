event_inherited();

if (active)
{
	dir = (xspeed != 0)? sign(xspeed) : dir;

	x += xspeed * scale;
	y += yspeed * scale;
}
// Inherit the parent event
event_inherited();

if (hp <= 0 && image_index == 0)
{
	image_index = 1;
	for (var i = -1; i < 2; ++i)
	{
		Create(x + i * xshift, y - yshift, oMissileAttacking, row);	
	}
}

if (x < oCamera.left - CAMERA_OFFSET)
{
	instance_destroy();	
}
// Inherit the parent event
event_inherited();

ContactDamage(10, 0);

if (hp <= 0 && shot_counter < shot_limit)
{
	
	
	if (t_offset <= 0)
	{
		image_index++;
		if (shot_counter == 0)	shot_counter++;
		Create(x - shot_counter * xshift, y - yshift, oMissileAttacking, row);	
		shot_counter++;
		t_offset = t_offset_max;
	}
	t_offset--;
}

with (oChargeStation)
{
	if (CheckCollisions(x, y, other, row))
	{
		instance_destroy(holo)
		instance_destroy();
	}
}

if (x < oCamera.left - CAMERA_OFFSET)
{
	instance_destroy();	
}
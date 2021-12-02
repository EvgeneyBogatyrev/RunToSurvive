event_inherited();

if (holo == noone && image_index == 0)
{
	holo = Create(x, y - 118 * scale, oChargeHolo, row);	
}

if (CheckCollisions(x, y, oPlayer, row) && image_index == 0)
{
	var _player = GetCollider(x, y, oPlayer, row);
	with (_player)  
	{
		bullets += irandom_range(4, 8);
		if (pocket[1] == ENERGYFIST_INUMBER)
		{
			bullets += 2;	
		}
	}
	
	image_speed = 1;
	image_index = 1;
	instance_destroy(holo);
}

if (AnimationEnd())
{
	image_index = 3;
	image_speed = 0;
}

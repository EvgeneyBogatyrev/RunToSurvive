event_inherited();

if (!image_index_set)
{
	image_index_set = true;
	image_index = irandom_range(0, image_number - 1);
}

if (destroyed)
{
	image_alpha -= 0.1;
	if (image_alpha < 0)
	{
		instance_destroy();	
	}
}


if (lava_block)
{
	sprite_index = sSpamRailsEmpty;
	var _collider = GetCollider(x - 5, y - 1, oPlayer, row);
	if (_collider == noone)
	{
		_collider = GetCollider(x + 5, y - 1, oPlayer, row);
	}
	if (_collider != noone)
	{
		DamageSpecificPlayer(_collider, GetStats("WallOfFleshBlock"));	
	}
}
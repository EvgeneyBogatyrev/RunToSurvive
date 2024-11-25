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
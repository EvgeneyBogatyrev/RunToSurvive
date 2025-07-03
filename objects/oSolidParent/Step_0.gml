/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

if (fade_away)
{
	real_image_alpha -= 0.05;
	if (real_image_alpha <= 0)
	{
		instance_destroy();	
	}
	image_alpha = real_image_alpha;
}


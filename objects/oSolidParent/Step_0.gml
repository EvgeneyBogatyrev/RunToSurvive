/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

if (fade_away)
{
	image_alpha -= 0.1;
	if (image_alpha <= 0)
	{
		instance_destroy();	
	}
}


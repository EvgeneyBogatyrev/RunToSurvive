/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if (CheckCollisions(x, y, oBlock, row))
{
	instance_destroy();	
}

ContactDamage(damage, 0);

// Inherit the parent event
event_inherited();


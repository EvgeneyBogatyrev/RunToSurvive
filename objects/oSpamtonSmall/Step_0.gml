/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if (CheckCollisions(x, y, oBlock, row) && x > oCamera.right)
{
	instance_destroy();	
}

if (CheckCollisions(x + xspeed, y, oBlock, row))
{
	repeat(abs(xspeed))
	{
		if (CheckCollisions(x + sign(xspeed), y, oBlock, row)) break;
		x += sign(xspeed);
	}
	xspeed *= -1;
}

ContactDamage(damage, 0);

if (hp <= 0)
{
	global.score += 5;
	with (Create(x, y, oItemDrop, row))
	{
		depth -= 2;
		image = choose(HEARTH_INUMBER);
	}
	
	instance_destroy();	
}

// Inherit the parent event
event_inherited();


event_inherited();

if (CheckCollisions(x, y, oPlayer, row))
{
	var _player = GetCollider(x, y, oPlayer, row);
	
	if (instance_exists(_player) && _player.state != UniversalStates.DEAD && _player.pocket[1] == CRUSH_INUMBER)
	{
		hp = 0;	
	}
}

if (hp <= 0)
{
	with (Create(x, y, oItemDrop, row))
	{
		depth -= 2;
		image = choose(STDGUN_INUMBER, POWERGUN_INUMBER, SHOTGUN_INUMBER, 
						ROCKET_LAUNCHER_INUMBER, LIFESTEAL_GUN_INUMBER, 
						ROCKETBOOTS_INUMBER, FORCEFIELD_INUMBER, ENERGYFIST_INUMBER,
						DOUBLEHEART_INUMBER, LIGHTNINGBOOTS_INUMBER, REALSHOTGUN_GUN_INUMBER,
						ELECTRIC_GUN_INUMBER, CRUSH_INUMBER, CHARGING_GUN_INUMBER);
	}
	instance_destroy();
}

if (x < oCamera.left - CAMERA_BOUNDS)  instance_destroy();

if (!CheckCollisions(x, y + 1, oSolidParent, row) && instance_exists(oWallOfFleshController))
{
	real_image_alpha -= 0.05;
	if (real_image_alpha <= 0)
	{
		instance_destroy();	
	}
	image_alpha = real_image_alpha;
}
		
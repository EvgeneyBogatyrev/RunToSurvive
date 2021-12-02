event_inherited();

if (hp <= 0)
{
	with (Create(x, y, oItemDrop, row))
	{
		depth -= 2;
		image = choose(STDGUN_INUMBER, POWERGUN_INUMBER, SHOTGUN_INUMBER, ROCKET_LAUNCHER_INUMBER, ROCKETBOOTS_INUMBER, FORCEFIELD_INUMBER, ENERGYFIST_INUMBER);
	}
	instance_destroy();
}

if (x < oCamera.left - CAMERA_BOUNDS)  instance_destroy();
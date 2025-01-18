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
		var _all_items = GetAllDropItems();
		image = _all_items[random_range(0, len(_all_items) - 1)];
		
		// To add new item to drop list, go to Items script.
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
		
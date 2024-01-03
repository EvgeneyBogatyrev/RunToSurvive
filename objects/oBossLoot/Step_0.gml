/// @description Angling
if (state == ItemDropStates.SPIN)
{
	ysp -= grav;
	if (CheckCollisions(x, y + ysp, oBlock, row))
	{
		repeat(abs(ysp))
		{
			if (CheckCollisions(x, y + sign(ysp), oBlock, row)) break;
			y += sign(ysp);
		}
		ysp = 0;
	}
	y += ysp;
	
	if (abs(x - destination_x) < destination_threshold)
	{
		//x = destination_x;
		xspeed = 0;
	}
	x += xspeed;
	
	
	
	var _player = noone;
	
	for (var i = 0; i < instance_number(oPlayer); ++i)
	{
		var _tmp = instance_find(oPlayer, i);
		if (_tmp.row == row && CheckCollisions(x, y, _tmp, row)) //&& abs(_tmp.x - x) < sprite_width / 2 * scale)
		{
			_player = _tmp;
			break;
		}
	}
	
	if (_player != noone && _player.state != UniversalStates.DEAD) 
	{
		GiveItemToPlayer(_player, profile);
		
		instance_destroy();
	}
	
	if (CheckCollisions(x, y, oObstacle, row))
	{
		x += 1;	
	}
	
	if (CheckCollisions(x, y, oStumpTree, row))
	{
		x += 1;	
	}
	
	if (x < oCamera.left - CAMERA_OFFSET) 
	{
		instance_destroy();
	}
	
}
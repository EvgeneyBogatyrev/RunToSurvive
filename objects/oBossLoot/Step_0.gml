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
	
	
	var _player = noone;
	
	for (var i = 0; i < instance_number(oPlayer); ++i)
	{
		var _tmp = instance_find(oPlayer, i);
		if (_tmp.row == row && abs(_tmp.x - x) < sprite_width / 2 * scale)
		{
			_player = _tmp;
			break;
		}
	}
	
	if (_player != noone && _player.state != UniversalStates.DEAD) 
	{
		GiveItemToPlayer(_player, profile);
		/*switch (index) 
		{
			case DELVER_LOOT_INUMBER:
			
				_player.onHitEvent[array_length(_player.onHitEvent)] = LightningStrike;
				break;
			
			default:
			
				Assert(false, "unknown boss loot index")
				break;
			
		
		}*/
		
		instance_destroy();
	}
	x = lerp(x, oCamera.x, 0.05);
	if (x < oCamera.left - CAMERA_OFFSET) 
	{
		instance_destroy();
	}
	
}
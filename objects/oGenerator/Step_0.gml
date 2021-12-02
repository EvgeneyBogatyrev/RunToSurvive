if (last_block[2].x <= oCamera.right + oCamera.view_w_half * GetScale(2))
{
	obstacles = GetObstacleCombination(oRoomControl.room_properties[? "ForbiddenObstacles"], obstacles);
	for (var i = 0; i < 3; ++i)
	{
		var _start_point = last_block[i].x;
		var _count = 0;
		while (last_block[i].x <=  oCamera.right + 2 * oCamera.view_w_half * GetScale(i))
		{
			var _x = last_block[i].x + (BLOCKSIZE - 1) * GetScale(i);
			last_block[i] = Create(_x, ground[i], oGroundBlock, i);
			with (last_block[i])
			{
				sprite_index = oRoomControl.room_properties[? "BlockSprite"];
			}
			if (_count % 3 == 0) 
			{
				with (Create(_x, ground[i] + BLOCKSIZE * GetScale(i), oTextureBlock, i))
				{
					sprite_index = oRoomControl.room_properties[? "BlockBigSprite"];	
				}
			}
			_count++;
		}
		CreateEnvironment(obstacles[i], _start_point, i);
	}
}


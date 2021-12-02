///@desc Check is player is visible (may be on a different row)
function PlayerVisible() {

	var _target = noone;
	for (var j = 0; j < instance_number(oPlayer); ++j) 
	{
		var _player = instance_find(oPlayer, j);
	
		if (row != _player.row)  continue;
		if (_player.state == UniversalStates.DEAD)  continue;
	
		var _flag = 1;
		var x_start = min(x, _player.x);
		var x_end = max(x, _player.x);
		
		var _height = y - sprite_height * scale;
		
		with (_player)
		{
			for (var i = x_start; i <= x_end; i += BLOCKSIZE * scale) 
			{
				if (CheckCollisions(i, _height, oSolidParent, row))
				{
					_flag = 0;
					break;
				}
			}
		}
		if (_flag) 
		{
			if (_target == noone)  _target = _player;	
			else
			{
				if (_player.y > _target.y)  _target = _player;
				else  if (abs(_target.x - x) > abs(_player.x - x))  _target = _player;
			}
		}
	}		
	
	return _target;


}

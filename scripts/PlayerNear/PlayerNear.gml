///@desc If player is visible from current row
function PlayerNear() {

	var _target = noone;

	for (var j = 0; j < instance_number(oPlayer); ++j) 
	{
	
		var _player = instance_find(oPlayer, j);
		if (_player.state == UniversalStates.DEAD)  continue;
	
		if (row == _player.row)
		{
			var flag = 1;
			var x_start = min(x, _player.x);
			var x_end = max(x, _player.x);
		
			for (var i = x_start; i <= x_end; i += BLOCKSIZE * scale) 
			{
				if (CheckCollisions(i, y - 1, oSolidParent, row))
				{
					flag = 0;
					break;
				}
			}
			if (flag) 
			{
				if (_target == noone || abs(_target.x - x) > abs(_player.x - x))  _target = _player;
			}
		}
	}


	return _target;


}

// Inherit the parent event

if (normal_move)
{
	for (var _i = number_of_segments - 1; _i > 0; _i--)
	{
		var _seg = segments[_i];
		if (_seg.warmup > 0)
		{
			_seg.warmup -= 1;
			continue;
		}
	
		var _spring = point_distance(_seg.x, _seg.y, segments[_i - 1].x, segments[_i - 1].y) * 0.5;
		var _angle = point_direction(_seg.x, _seg.y, segments[_i - 1].x, segments[_i - 1].y);
		_seg.x += lengthdir_x(_spring, _angle);
		_seg.y += lengthdir_y(_spring, _angle);
	}
}

for (var _i = number_of_segments - 1; _i >= 0; _i--)
{
	var _seg = segments[_i];
	_seg.x += random_velocities[_i].x;
	_seg.y += random_velocities[_i].y;
}

event_inherited();

if (normal_move)
{
	segments[0].x = x;
	segments[0].y = y;
}

if (hp < 0)
{
	state = UniversalStates.DEAD;	
}


// Damage player

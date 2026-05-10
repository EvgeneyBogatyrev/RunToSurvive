/// @description Angling
if (state == ItemDropStates.SPIN)
{
	var _edge_margin = 64 * scale;
	var _left_limit = oCamera.left + CAMERA_BOUNDS + _edge_margin;
	var _right_limit = oCamera.right - CAMERA_BOUNDS - _edge_margin;
	if (_left_limit > _right_limit)
	{
		_left_limit = oCamera.left + CAMERA_BOUNDS;
		_right_limit = oCamera.right - CAMERA_BOUNDS;
	}

	if (!destination_ready)
	{
		var _landing_y = oGenerator.ground[row] - 18 * scale;
		var _start_destination = BoundBetween(destination_x, _left_limit, _right_limit);
		var _best_destination = _start_destination;
		var _found_destination = false;
		var _destination_scan_step = max(8, 24 * scale);
		var _destination_scan_max = _right_limit - _left_limit;

		for (var _destination_offset = 0; _destination_offset <= _destination_scan_max && !_found_destination; _destination_offset += _destination_scan_step)
		{
			for (var _destination_try = 0; _destination_try < 2; _destination_try++)
			{
				if (_destination_offset == 0 && _destination_try == 1) continue;

				var _destination_candidate = _start_destination + (_destination_try == 0 ? -_destination_offset : _destination_offset);
				if (_destination_candidate < _left_limit || _destination_candidate > _right_limit) continue;

				var _destination_blocked = (
					CheckCollisions(_destination_candidate, _landing_y, oObstacle, row) ||
					CheckCollisions(_destination_candidate, _landing_y - 32 * scale, oObstacle, row) ||
					CheckCollisions(_destination_candidate, _landing_y, oStumpTree, row) ||
					CheckCollisions(_destination_candidate, _landing_y - 32 * scale, oStumpTree, row) ||
					CheckCollisions(_destination_candidate, _landing_y, oStructureBlock, row) ||
					CheckCollisions(_destination_candidate, _landing_y - 32 * scale, oStructureBlock, row) ||
					CheckCollisions(_destination_candidate, _landing_y, oChargeStation, row) ||
					CheckCollisions(_destination_candidate, _landing_y, oChest, row)
				);

				if (!_destination_blocked)
				{
					_best_destination = _destination_candidate;
					_found_destination = true;
					break;
				}
			}
		}

		destination_x = _best_destination;
		xspeed = BoundBetween((destination_x - x) / 50, -6, 6);
		destination_ready = true;
	}

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
	
	if (abs(x - destination_x) < destination_threshold || sign(destination_x - x) != sign(xspeed))
	{
		x = destination_x;
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
		exit;
	}

	if (CheckCollisions(x, y, oBlock, row))
	{
		repeat(96)
		{
			if (!CheckCollisions(x, y, oBlock, row)) break;
			y -= 1;
		}
		ysp = 0;
	}

	var _blocked_by_static = (
		CheckCollisions(x, y, oObstacle, row) ||
		CheckCollisions(x, y - 16 * scale, oObstacle, row) ||
		CheckCollisions(x, y, oStumpTree, row) ||
		CheckCollisions(x, y - 16 * scale, oStumpTree, row) ||
		CheckCollisions(x, y, oStructureBlock, row) ||
		CheckCollisions(x, y - 16 * scale, oStructureBlock, row) ||
		CheckCollisions(x, y, oChargeStation, row) ||
		CheckCollisions(x, y, oChest, row)
	);

	if (_blocked_by_static)
	{
		stuck_timer++;

		var _clear_start = BoundBetween(x, _left_limit, _right_limit);
		var _clear_x = _clear_start;
		var _found_clear_x = false;
		var _clear_scan_step = max(4, 12 * scale);
		var _clear_scan_max = _right_limit - _left_limit;

		for (var _clear_offset = 0; _clear_offset <= _clear_scan_max && !_found_clear_x; _clear_offset += _clear_scan_step)
		{
			for (var _clear_try = 0; _clear_try < 2; _clear_try++)
			{
				if (_clear_offset == 0 && _clear_try == 1) continue;

				var _candidate_x = _clear_start + (_clear_try == 0 ? -_clear_offset : _clear_offset);
				if (_candidate_x < _left_limit || _candidate_x > _right_limit) continue;

				var _candidate_blocked = (
					CheckCollisions(_candidate_x, y, oBlock, row) ||
					CheckCollisions(_candidate_x, y, oObstacle, row) ||
					CheckCollisions(_candidate_x, y - 16 * scale, oObstacle, row) ||
					CheckCollisions(_candidate_x, y, oStumpTree, row) ||
					CheckCollisions(_candidate_x, y - 16 * scale, oStumpTree, row) ||
					CheckCollisions(_candidate_x, y, oStructureBlock, row) ||
					CheckCollisions(_candidate_x, y - 16 * scale, oStructureBlock, row) ||
					CheckCollisions(_candidate_x, y, oChargeStation, row) ||
					CheckCollisions(_candidate_x, y, oChest, row)
				);

				if (!_candidate_blocked)
				{
					_clear_x = _candidate_x;
					_found_clear_x = true;
					break;
				}
			}
		}

		if (_found_clear_x)
		{
			x = _clear_x;
			destination_x = _clear_x;
			xspeed = 0;
			stuck_timer = 0;
		}
		else if (stuck_timer > 10)
		{
			y -= 4 * scale;
			ysp = 0;
		}
	}
	else
	{
		stuck_timer = 0;
	}
	
	if (x < oCamera.left - CAMERA_OFFSET || x > oCamera.right + CAMERA_OFFSET)
	{
		instance_destroy();
		exit;
	}
	
}

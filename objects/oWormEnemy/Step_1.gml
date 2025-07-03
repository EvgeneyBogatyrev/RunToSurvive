if (!init)
{
	init = true;
	for (var _i = 0; _i < number_of_segments; _i++)
	{
		segments[_i] = 
		{
			x : x,
			y : y,
			rotation : 0,
			warmup : _i
		}
		random_velocities[_i] = 
		{
			x : 0,
			y : 0,
		}
	}	
	
	collision_detector = function()
	{	
		var _masks = [];
	    for (var i = 0; i < array_length(segments); i++) {
	        var _x_pos = segments[i].x;
	        var _y_pos = segments[i].y;
			var _sprite = segment_sprite; // body
			if (i == 0)
			{
				_sprite = head_sprite; // head
			}
			else if (i == array_length(segments) - 1)
			{
				_sprite = tail_sprite;	// tail
			}
	        array_push(_masks, [_x_pos, _y_pos, _sprite]);
	    }
	    return _masks;	
	}
}

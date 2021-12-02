/// @description follow target, resize screen

x_to = follow.x;
y_to = follow.y;

if (mode == CameraMode.MOVING)
{	
	if (follow == oPlayer)
	{
		var _x = 0,  _y = 0;
		for (var i = 0; i < instance_number(oPlayer); ++i)
		{
			var _player = instance_find(oPlayer, i);
			_x += _player.x;
			_y += _player.y;
		}
		_x /= instance_number(oPlayer);
		_y /= instance_number(oPlayer);
	
		x_to = _x;
		y_to = _y;
	}
}

//Assert(instance_exists(follow), "No object to follow\n");

view_w_half = camera_get_view_width(cam) * 0.5;
view_h_half = camera_get_view_height(cam) * 0.5;

left = x - view_w_half;
right = x + view_w_half;

//Screen shake
y = clamp(y, view_h_half + buff, room_height - view_h_half - buff);

if (x_to > x || mode == CameraMode.STATIC || focus = CameraFocus.TARGET_ZOOM)  x += (x_to - x)/camera_speed;
	
y += (y_to - y)/camera_speed;

x += random_range(-shake_remain, shake_remain);
y += random_range(-shake_remain, shake_remain);
shake_remain = max(0, shake_remain - ((1/shake_lenght)*shake_magnitude));
	
//Focus
switch (focus)
{
	case CameraFocus.ROW0:
		camera_set_view_size(cam, max(2 * view_w_half - 5/2, 800), max(2 * view_h_half - 45/32, 450));	
		break;
	case CameraFocus.ROW1:
		camera_set_view_size(cam, max(2 * view_w_half - 5/2, 900), max(2 * view_h_half - 45/32, 506.25));	
		break;
	case CameraFocus.ROW2:
		camera_set_view_size(cam, min(2 * view_w_half + 5/2, 1024), min(2 * view_h_half + 45/32, 576));	
		break;
	case CameraFocus.TARGET_ZOOM:
		camera_set_view_size(cam, 2 * view_w_half - 5/2, 2 * view_h_half - 45/32);	
		break;
	default:
		Raise("Wrong camera focus\n");
		break;
}

camera_set_view_pos(cam, x - view_w_half, y - view_h_half);

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
center = (left + right) / 2;

//Screen shake
y = clamp(y, view_h_half + buff, room_height - view_h_half - buff);

if (x_to > x || mode == CameraMode.STATIC || focus = CameraFocus.TARGET_ZOOM)  x += (x_to - x)/camera_speed;
	
y += (y_to - y)/camera_speed;

x += random_range(-shake_remain, shake_remain);
y += random_range(-shake_remain, shake_remain);
shake_remain = max(0, shake_remain - ((1/shake_lenght)*shake_magnitude));
	
var _w = global.display_width;
var _h = global.display_height;

var _speed_x = 5;
var _speed_y = 45/16;

var _w_to = cam_widths[focus];
var _h_to = cam_heights[focus];

var _cam_w = Approach(2 * view_w_half, _w_to, _speed_x);
var _cam_h = Approach(2 * view_h_half, _h_to, _speed_y);


camera_set_view_size(cam, _cam_w, _cam_h);	

Assert(focus <= CameraFocus.TARGET_ZOOM && focus >= CameraFocus.ROW0, "Wrong camera focus >:(\n") 

//Focus

camera_set_view_pos(cam, x - view_w_half, y - view_h_half);


if (need_to_refocus && shake_remain == 0)
{
	x = refocus_position_x;	
	y = refocus_position_y;	
	need_to_refocus = false;
}
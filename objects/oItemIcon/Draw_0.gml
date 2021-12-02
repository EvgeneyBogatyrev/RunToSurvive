/// @description
draw_set_alpha(0.7);

draw_set_color(c_blue);
var _radius = sprite_get_width(sItems) / 2 * scale;
for (var i = 0; i < 360; ++i)
{
	if (i / 360 > time / max_time)  break;
	draw_line_width(x, y, x - dsin(i) * _radius, y - dcos(i) * _radius, 2);
}

draw_set_color(c_white);
draw_sprite_ext(sItemTimer, 0, x, y, 2.2 * scale, 2.2 * scale, 0, c_white, 1);
//draw_circle(x, y, _radius * 2/3, false);

draw_sprite_ext(sItems, index, x, y, 0.7 * scale, 0.7 * scale, 0, c_white, 1);
draw_set_alpha(1);
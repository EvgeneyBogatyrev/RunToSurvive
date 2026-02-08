var _health_percentage;
var _bar_colour = c_red;
if (instance_exists(boss))
{
	_health_percentage = hp_visual / boss.cum_hp_max;
	if boss.is_invincible _bar_colour = c_gray;
}
else
{
	_health_percentage = 0;
}

if (state == BossHBStates.HIDDEN) exit;



var _sprite = sBossHealthBar;

var _sprite_width = sprite_get_width(_sprite);
var _sprite_height = sprite_get_height(_sprite);

var _border_width = 8;

var _x = display_get_gui_width() / 2;
var _y = display_get_gui_height() - y_offset;

var _top = _y + _border_width;
var _bottom = _y + _sprite_height - _border_width;

var _left = _x - _sprite_width/2 + _border_width;
var _right = _left + ((_sprite_width - _border_width * 2) * _health_percentage)


draw_set_colour(_bar_colour);

draw_rectangle(_left, _top, _right, _bottom, false);

draw_set_colour(c_white);

draw_sprite(sBossHealthBar, 0, _x, _y);

/*

if (state != UniversalStates.VICTORY)
{
	draw_healthbar(display_get_gui_width() - 210, 25, 
	display_get_gui_width() - 30, 60, int64(shown_hp / cum_hp_max * 100), 
	c_gray, c_red, c_red, -1, 1, 1);
}
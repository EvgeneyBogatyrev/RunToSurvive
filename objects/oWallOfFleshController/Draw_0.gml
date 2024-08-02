/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

for (var _i = 0; _i < 60; _i++)
{
	
	var _x = ((_i mod 5) * 64) - 64 * 4;
	
	var _y = (_i div 5) * 64;
	
	if (_i mod 5 == 4)
	draw_sprite(sWoF_border, _i div 5, further_eye.x + _x, _y);
	else
	draw_sprite_ext(sWoF, _i, further_eye.x + _x, _y, 1, 1, 90 * _i, c_white, 1);

}

for (var _i = 0; _i < 24; _i++)
{
	var _x = ((_i mod 2) * 64) - 64 * 5;
	var _y = (_i div 2) * 64;
	
	var _n = (_i mod 2 == 1);
	
	draw_sprite_ext(sWoF_border, _i, further_eye.x + _x, _y, _n*2-1, 1, 0, c_gray, 1);
}
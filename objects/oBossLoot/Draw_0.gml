/// @description Drawing sprite;


var _scale = (state == ItemDropStates.SPIN)?  scale * 2/3 : scale / 2;

draw_set_color(c_white);
draw_set_alpha(0.5);
draw_circle(x, y - 50 * _scale, 50 * _scale, false);

draw_set_alpha(1);

draw_sprite_ext(sPassiveItems, profile.icon_index, x, y - 50 * _scale, _scale * sin((get_timer() - phase) / 500000), _scale, 0, c_white, 1);


draw_set_font(fntItemDescription);
draw_set_alpha(0.5);
draw_set_color(c_black);
var _x_offset = 10;
var _y_offset = 10;

var _text_width = 220;
var _text_height = string_height_ext(profile.description, 16, _text_width);

var _y_point = y - 100 * scale;


draw_rectangle(x - (_text_width / 2 + _x_offset), _y_point - _text_height / 2 - _y_offset, x + _text_width / 2 + _x_offset, _y_point + _text_height / 2 + _y_offset, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_set_font(fntItemDescription);
draw_set_color(c_white);
draw_set_valign(fa_center);
draw_text_ext_transformed(x, _y_point, profile.description, 16, _text_width, 1, 1, 0);
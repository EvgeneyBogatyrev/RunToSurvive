/// @description Drawing sprite;


var _scale = (state == ItemDropStates.SPIN)?  scale * 2/3 : scale / 2;

draw_set_color(c_white);
draw_set_alpha(0.5);
draw_circle(x, y - 50 * _scale, 50 * _scale, false);

draw_set_alpha(1);

draw_sprite_ext(sPassiveItems, index, x, y - 50 * _scale, _scale * sin((get_timer() - phase) / 500000), _scale, 0, c_white, 1);
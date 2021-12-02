///@desc Draw textbox with sprite
///@param centerx
///@param bottomy
///@param max_width
///@param sprite
///@param index
///@param text
///@param halign
function DrawTextboxExt(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {


	var _x = argument0;
	var _y = argument1;
	var _width = argument2;
	var _sprite = argument3;
	var _index = argument4;
	var _text = argument5;
	var _halign = argument6;

	var _offset = 5;
	var _font = CstmFnt;
	var _font_size = font_get_size(_font);
	var _sep = _font_size * 3/2;

	draw_set_font(_font);
	draw_set_color(c_white);
	draw_set_alpha(0.7);

	var _text_width = string_width_ext(_text, _sep, _width);
	var _text_height = string_height_ext(_text, _sep, _width);

	var _total_width = sprite_get_width(_sprite) / 2 + _offset * 3 + _text_width;
	var _total_height = max(sprite_get_height(_sprite) / 2, _text_height) + _offset * 2;

	DrawNineSlice(sNineSliceBox, _x - _total_width / 2, _y - _total_height, _x + _total_width / 2, _y);

	var _cur_x = _x - _total_width / 2;
	var _cur_y = _y - _total_height;

	_cur_x += _offset;

	draw_sprite_ext(_sprite, _index, _cur_x + sprite_get_width(_sprite) / 4, _cur_y + _total_height/2, 0.5, 0.5, 0, c_white, draw_get_alpha());

	_cur_y += _offset;
	_cur_x += sprite_get_width(_sprite)/2 + _offset;

	if (_halign == fa_center)  _cur_x += _text_width/2;

	draw_set_halign(_halign);
	draw_set_valign(fa_top);

	draw_text_ext(_cur_x, _cur_y, _text, _sep, _width);

	draw_set_color(c_black);
	draw_set_alpha(1);



}

/// @description

var _width = 256;
var _height = 256;

if (number_of_players > 0) 
{
	var _label_w = _width / number_of_players;
	var _label_h = 32;
}

var _offset = (room_width - number_of_characters * _width) / (number_of_characters + 1);

var _cur_x = _offset + sprite_get_width(sKyronImage) / 2;
var _cur_y = room_height / 2;

for (var i = 0; i < number_of_characters; ++i)
{
	//var _colors = [c_red, c_aqua, c_yellow, c_green];

	draw_set_alpha(0.5);
	var _color = -1;
	
	for (var j = 0; j < number_of_players; ++j)
	{
		if (lock[j] && choices[j] == i)
		{
			_color = player_colors[j];
			break;
		}
	}
	
	if (_color != -1)
	{
		draw_set_color(_color);
		draw_roundrect(_cur_x - _width / 2 - 7, _cur_y - _height / 2 - 7, _cur_x + _width / 2 + 7, _cur_y + _height / 2 + 7, false);
	}
	
	draw_set_color(c_black);
	draw_roundrect(_cur_x - _width / 2 - 2, _cur_y - _height / 2 - 2, _cur_x + _width / 2 + 2, _cur_y + _height / 2 + 2, false);
	draw_set_alpha(1);
	if (_color == -1)  draw_roundrect(_cur_x - _width / 2 - 2, _cur_y - _height / 2 - 2, _cur_x + _width / 2 + 2, _cur_y + _height / 2 + 2, true);
	
	draw_sprite_ext(images[i], 0, _cur_x, _cur_y, 1, 1, 0, c_white, draw_get_alpha());	
	
	for (var j = 0; j < number_of_players; ++j)
	{
		if(choices[j] == i)
		{
			var _label_x = _cur_x - _width/2 + j*_label_w;
			var _label_y = _cur_y - _height/2;
			draw_set_color(player_colors[j]);
			draw_roundrect(_label_x, _label_y - _label_h, _label_x + _label_w, _label_y,false);
			draw_set_font(CstmFnt);
			draw_set_color(c_white);
			draw_set_halign(fa_middle);
			draw_set_valign(fa_center);
			draw_text(_label_x + _label_w / 2, _label_y - _label_h / 2,  "P" + string(j + 1));
		}
	}
	
	
	_cur_x += sprite_get_width(sKyronImage) + _offset;
}

DrawTextboxExt(room_width/2, room_height - 20, room_width/2, sEmpty, 0,
"Z/"+CF_ICONS_XBOX_A+"/"+CF_ICONS_PS_CR+" - join, select character or remove selection\nX/"+CF_ICONS_XBOX_B+"/"+CF_ICONS_PS_CR+" - disconnect\nEscape/"+CF_ICONS_SELECT+" - exit to menu\nEnter/"+CF_ICONS_START+" - start the game", fa_center);

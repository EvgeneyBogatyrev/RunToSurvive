var _size = ds_list_size(current_menu.fields);

var _x0 = room_width / 2;
var _y0 = room_height / 2;

draw_set_color(c_white);
draw_set_alpha(1);


draw_set_font(CstmFntOutline);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var _i = 0; _i < _size; _i++)
{
	
	var _name = current_menu.fields[| _i].name;
	
	var _max = string_width(_name);

	var _col = (cursor_pos == _i) ? c_green : c_white;
	
	DrawMenuButton(_name, _max + 5, _col, _x0, _y0 + _i*50);
	
	
}
///@desc DrawMenu(buttons, position);
///@arg buttons
///@args position
function DrawMenu(argument0, argument1) {

	///Draws menu-type data structure.

	draw_set_alpha(1);
	draw_set_color(c_white);

	var buttons = argument0;
	var position = argument1;

	var length = array_length_1d(buttons);
	var font = CstmFntOutline;

	var space = font_get_size(fntMenu)*3/2;
	var required_space = length * space + (length - 1)* space/2;

	var xx = room_width/2;
	var yy = room_height/2 - required_space/2;

	draw_set_font(font);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);

	var maxsize = 0;

	for (var i = 0; i < length; i++)
	{
		var cur_button = buttons[i]	;
		var cur_size = string_width(cur_button);

		if (maxsize < cur_size)
			maxsize = cur_size;
	}



	for (var i = 0; i < length; i++)
	{
		if (position == i)  DrawMenuButton(buttons[i], maxsize, c_green, xx, yy + i*3/2*space);	
		else                DrawMenuButton(buttons[i], maxsize, c_white, xx, yy + i*3/2*space);
	
	}



}

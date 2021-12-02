///@desc DrawMenuButton
///@arg text
///@arg size
///@arg color
///@arg x
///@arg y
function DrawMenuButton(argument0, argument1, argument2, argument3, argument4) {

	///Draw text in the box

	var text = argument0;
	var size = argument1;
	var color = argument2;
	var xx = argument3;
	var yy = argument4;

	var box_offset = 8;
	var centerx = room_width/2;

	draw_set_alpha(0.8);
	draw_set_color(c_gray);
	draw_roundrect(centerx - size/2 - box_offset, yy - font_get_size(fntMenu) - 1, centerx + size/2 + box_offset, yy + font_get_size(fntMenu) + 1, false);
	draw_set_alpha(1);

	draw_set_color(color);
	draw_text(xx, yy, text);



}

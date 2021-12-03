/// @description Draw text.

//Reset draw settings
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_font(CstmFntOutline);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

//Draw buttons
var maxsize = 0;
for (var i = 0; i < array_length_1d(button); i++)
	if (maxsize < string_width(button[i]))
		maxsize = string_width(button[i]);
	
for (var i = 0; i < array_length_1d(button); i++)
{
	if (cursor_position == i) DrawMenuButton(button[i], maxsize + 5, c_green, x0, y0_cur + i*50);	
	else					  DrawMenuButton(button[i], maxsize + 5, c_white, x0, y0_cur + i*50);	
}
//DrawTextOutline(button[0], 1, x0, y0_cur);
//DrawTextOutline(button[1], 1, x0, y0_cur + 50);
//DrawTextOutline(button[2], 1, x0, y0_cur + 100);
//DrawTextOutline(button[3], 1, x0, y0_cur +150);

//Draw title
/*
draw_set_font(fntTitle);
draw_set_color(c_white);
DrawTextOutline("< RUN TO SURVIVE >", 1, x0, yTitle_cur);
*/

draw_sprite_ext(sTitle,0,x0,yTitle_cur,2,2,sin(current_time/256)*4,c_white,1);

//Draw black screen
draw_set_color(c_black);
draw_set_alpha(alpha);
draw_rectangle(0, 0, room_width, room_height, 0);

//if (not centered)
//{
//	window_center();
//	centered = true;	
//}

/// @description Draw pause menu
var rw = (window_get_fullscreen()) ? room_width : display_get_gui_width();
var rh = (window_get_fullscreen()) ? room_height : display_get_gui_height();

var centerx = rw/2;
var centery = rh/2;
var offsetx = rw/4;
var offsety = rh/4;

if (paused)
{
		
	draw_sprite(background, 0, 0, 0);
		
	if (MODE == "Menu")
	{
		
		draw_set_color(c_black);
		draw_set_alpha(0.6);
		draw_rectangle(centerx-offsetx, centery-offsety, centerx+offsetx, centery+offsety, 0);
		draw_set_font(CstmFntOutline);
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		draw_text((rw/2), (rh/3), "PAUSED");
		for(var i = 0; i<=max_cursor; i++)
		{
			var add1 = "<";
			var add2 = ">";
			if not (cursor_position == i) {add1 = ""; add2 = "";}
			draw_text((rw/2), (rh/3)+52*(i+1), add1 + button[i] + add2);
		}
		//else DrawMenu(button, cursor_position);
	}
	else if (MODE == "Equipment")
	{
		
		draw_set_color(c_black);
		draw_set_alpha(0.6);
		draw_rectangle(centerx-offsetx/2, 32, centerx+offsetx/2, 64 + string_height("EQUIPMENT"), 0);
		draw_rectangle(centerx-offsetx/3, rh - 64 - string_height(ebutton[0]), centerx+offsetx/3, rh - 32, 0);
		
		draw_set_alpha(1);
		draw_set_halign(fa_center);

		DrawTextOutline("EQUIPMENT", 1, centerx, 60);
		DrawTextOutline("<" + ebutton[0] + ">", 1, centerx, rh - 60);
		
		var cur_y = 64 + string_height("EQUIPMENT") + 50;
		
		draw_sprite(sKyronIcon, 0, offsetx/2, cur_y);
		
		
	}
}

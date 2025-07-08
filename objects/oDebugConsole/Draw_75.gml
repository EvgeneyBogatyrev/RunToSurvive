if !enabled return;

draw_set_color(c_black);
draw_set_alpha(0.3);
draw_rectangle(0, 0, window_get_width(), window_get_height() / 2, false);
draw_rectangle(0, (window_get_height() / 2) - 64 , window_get_width(), window_get_height() / 2, false);


draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_font(fntItemDescription);

var _cursor = sin(current_time / 100) >= 0 ? "|" : ""

draw_text(16, window_get_height() / 2, keyboard_string + _cursor);

draw_set_color(c_white);
draw_set_alpha(0.8);
for (var _i = 0; _i < ds_list_size(history); _i++)
{
	draw_text(16, window_get_height() / 2 - 32 * (_i + 1) , history[|_i]);
}

draw_set_font(fntMenu);
draw_set_alpha(1);

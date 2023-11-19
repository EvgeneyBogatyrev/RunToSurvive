draw_set_font(fntMenu);
draw_set_halign(fa_center);
if (global.score < global.highscore)
{
	draw_text(display_get_gui_width() / 2, 25, string(global.score) + "/" + string(global.highscore));
}
else
{
	draw_text(display_get_gui_width() / 2, 25, string(global.score) + " - HIGHSCORE!");
}
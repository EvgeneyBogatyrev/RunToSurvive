/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

if (state != UniversalStates.VICTORY)
	draw_healthbar(display_get_gui_width() - 210, 75, display_get_gui_width() - 30, 110, int64(bullets / 20 * 100), c_gray, c_yellow, c_yellow, -1, 1, 1);



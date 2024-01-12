if (state != UniversalStates.VICTORY)
	draw_healthbar(display_get_gui_width() - 210, 25, display_get_gui_width() - 30, 60, int64(shown_hp / cum_hp_max * 100), c_gray, c_red, c_red, -1, 1, 1);

/// @description Draw healthbar
event_inherited();

draw_set_alpha(healthbar_alpha);
healthbar_alpha -= 0.01;

if (shown_hp >= 0)  
	draw_healthbar(x - 30 * scale, y - (sprite_height + 10 * scale), x + 30 * scale, y - sprite_height, shown_hp / maxhp * 100, c_gray, c_red, c_red, -1, 0, 0);

draw_set_alpha(1);

/// @description Powergun heathbar

draw_self();

if (temp_bullets > 0)
{
	var _x = host.x;
	var _y = host.y;
	draw_healthbar(_x - 30 * scale, _y - 15 * scale - host.sprite_height, _x + 30 * scale, _y - 25 * scale - host.sprite_height, temp_bullets, c_black, c_green, c_green, -1, 1, 1);
}	

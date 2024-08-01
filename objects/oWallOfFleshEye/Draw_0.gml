/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

with(oPlayer)
{
	draw_line(x - xspeed, y - sprite_height / 2 * scale, other.x, other.y);
}
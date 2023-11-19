/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
if (hp <= 0)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, image_blend, draw_alpha);
else
	event_inherited();



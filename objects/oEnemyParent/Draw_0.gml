/// @description Draw hit flash

draw_self();
//if (crowned) draw_sprite_ext(sCrown, 0, x, bbox_top, scale, scale, 0, image_blend, image_alpha);

if (hit_flash > 0)
{
	hit_flash--;
	shader_set(shdHit);
	draw_self();
	shader_reset();
}


if (on_fire && state != UniversalStates.DEAD)
{
	draw_sprite(sFire, int64(get_timer() / 125000), x + fire_x_shift, y - 30 + fire_y_shift);	
}
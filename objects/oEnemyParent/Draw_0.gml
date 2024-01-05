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

/// @description Draw hit flash

draw_self();

if (hit_flash > 0)
{
	hit_flash--;
	shader_set(shdHit);
	draw_self();
	shader_reset();
}

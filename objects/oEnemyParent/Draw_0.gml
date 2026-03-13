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

if (state != UniversalStates.DEAD)
{
	var _effect_names = struct_get_names(status_effects)

	for (var _i = 0; _i < len(_effect_names); _i++)
	{
		var _effect = struct_get(status_effects, _effect_names[_i]);
	
		_effect.profile.draw(id);
	}
}


if (on_fire && state != UniversalStates.DEAD)
{
	draw_sprite(sFire, int64(get_timer() / 125000), x + fire_x_shift, y - 30 + fire_y_shift);	
}

if (wildvines_timer > 0)
{
	draw_sprite(sWildvine, image_index, x, bbox_top);	
	draw_sprite(sWildvine, image_index + 1, x - sprite_width / 3, bbox_top);	
	draw_sprite(sWildvine, image_index + 2, x + sprite_width / 3, bbox_top);	
	
	
}
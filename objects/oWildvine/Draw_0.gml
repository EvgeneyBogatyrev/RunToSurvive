/// @description Insert description here
// You can write your code in this editor


var _w = sprite_get_width(sprite_index);

for (var _i = 0; _i < vine_count; _i++)
{
	var _x = x - _w / 2 * scale;
	draw_sprite_ext(sprite_index, vine_index[_i], _x + _w * scale / (vine_count - 1) * _i, y, scale, scale, 0, image_blend, image_alpha);
}

if (hit_flash > 0)
{
	hit_flash--;
	shader_set(shdHit);
	for (var _i = 0; _i < vine_count; _i++)
	{
		var _x = x - _w / 2 * scale;
		draw_sprite_ext(sprite_index, vine_index[_i], _x + _w * scale / (vine_count - 1) * _i, y, scale, scale, 0, image_blend, image_alpha);
	}
	shader_reset();
}


if (init)
{
	if (hit_flash > 0)
	{
		hit_flash--;
		shader_set(shdHit);
		draw_sprite_ext(head_sprite, 0, segments[0].x, segments[0].y, 1, 1, segments[0].rotation, image_blend, image_alpha * real_image_alpha);

		for (var _i = 1; _i < number_of_segments - 1; _i++)
		{
			draw_sprite_ext(segment_sprite, 0, segments[_i].x, segments[_i].y, 1, 1, segments[_i].rotation, image_blend, image_alpha * real_image_alpha);

		}

		draw_sprite_ext(tail_sprite, 0, segments[number_of_segments - 1].x, segments[number_of_segments - 1].y, 1, 1, segments[number_of_segments - 1].rotation, image_blend, image_alpha * real_image_alpha);
	
		shader_reset();
	}
	else
	{
		draw_sprite_ext(head_sprite, 0, segments[0].x, segments[0].y, 1, 1, segments[0].rotation, image_blend, image_alpha * real_image_alpha);

		for (var _i = 1; _i < number_of_segments - 1; _i++)
		{
			draw_sprite_ext(segment_sprite, 0, segments[_i].x, segments[_i].y, 1, 1, segments[_i].rotation, image_blend, image_alpha * real_image_alpha);

		}

		draw_sprite_ext(tail_sprite, 0, segments[number_of_segments - 1].x, segments[number_of_segments - 1].y, 1, 1, segments[number_of_segments - 1].rotation, image_blend, image_alpha * real_image_alpha);
	
	}

}
/// @description Draw outline

if (0 && (sprite_index == sGravestone || sprite_index == sDryTree))
{
	upixelH = shader_get_uniform(shdOutline, "pixelH");	
	upixelW = shader_get_uniform(shdOutline, "pixelW");	
	texelW = texture_get_texel_width(sprite_get_texture(sprite_index, image_index));
	texelH = texture_get_texel_height(sprite_get_texture(sprite_index, image_index));
	
	shader_set(shdOutline);
	shader_set_uniform_f(upixelW, texelW);
	shader_set_uniform_f(upixelH, texelH);
	draw_self();
	shader_reset();
}
else  draw_self();

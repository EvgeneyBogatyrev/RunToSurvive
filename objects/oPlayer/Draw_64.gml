//@desk Draw out of screen icon
if (x + sprite_width / 2 < oCamera.left)
{
	draw_sprite_ext(sPlayerOutOfScreen, 0, 0, (bbox_top) / STANDART_DEFINITION_HEIGHT * global.display_height, scale, scale, 0, c_white, image_alpha);
}

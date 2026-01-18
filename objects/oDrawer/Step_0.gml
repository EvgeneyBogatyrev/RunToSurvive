if (keyboard_check_pressed(vk_f4))
{
	window_enable_borderless_fullscreen(!window_get_borderless_fullscreen());
	window_set_fullscreen(!window_get_fullscreen());
}

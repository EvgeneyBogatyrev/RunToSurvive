/// @description Draw damage blinking.

if (state = UniversalStates.DEAD) image_alpha = image_alpha * death_alpha;


if (damaged and hp > 0)
{
	shader_set(shdFlash);

	shade_alpha = shader_get_uniform(shdFlash, "_alpha");
	shader_set_uniform_f(shade_alpha, flash);

	if (go_up)
	{
		flash += 0.05;
		if (flash >= 0.8)
		{
			go_up = false;
			flash = 0.8;
		}
	}
	else
	{
		flash -= 0.05;
		if (flash <= 0)
		{
			go_up = true;	
		}
	}

	draw_self();
	shader_reset();
}

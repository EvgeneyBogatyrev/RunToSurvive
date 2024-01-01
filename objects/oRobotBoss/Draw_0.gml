// Inherit the parent event
event_inherited();

//draw_text(oCamera.x, oCamera.y, depth);

if (draw_screen && (state == RobotBossStates.IDLE || state == RobotBossStates.WAIT_FOR_ROBOT || state == UniversalStates.INTRO))
{
	screen_image_change_counter--;
	if (screen_image_tick == 0 && screen_image_change_counter <= 0)
	{
		if (state == RobotBossStates.WAIT_FOR_ROBOT || state == UniversalStates.INTRO)
		{
			screen_image_offset = 6;	
		}
		else if (instance_exists(oMissileLauncher) && oMissileLauncher.hp > 0)
		{
			screen_image_offset = 3;	
		}
		else
		{
			screen_image_offset = choose(0, 6, 6);	
		}
		damaged = false;
	}
	
	if (hp != prev_hp && screen_image_offset != 9)
	{
		screen_image_offset = 9;
		screen_image_tick = 0;
		screen_image_change_counter = screen_image_change_counter_max / 2;
		damaged = true;
	}
	prev_hp = hp;	
	
	
	if (screen_image_change_counter <= 0)
	{
		screen_image_change_counter = screen_image_change_counter_max / (damaged ? 2 : 1);
		screen_image_tick = (screen_image_tick + 1) % 3;
	}
	
	draw_sprite_ext(sRobotBossScreenImages, 
		screen_image_offset + screen_image_tick,
		x + screen_image_offset_x + irandom_range(-3, 3) * (damaged ? 1 : 0), 
		y + screen_image_offset_y + irandom_range(-3, 3) * (damaged ? 1 : 0),
		image_xscale,
		image_yscale,
		image_angle,
		c_white,
		image_alpha
	);
}

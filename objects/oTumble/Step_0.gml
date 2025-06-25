event_inherited();

if (!need_to_tumble)
{
	with (oPlayer)
	{
		if (row == 0)
		{
			other.need_to_tumble = true;	
		}
	}
}

if (need_to_tumble)
{
	shock_counter--;
	
	if (instance_exists(oGunManDrone) && shock_counter <= shock_counter_drone_threshold)
	{
		oGunManDrone.stomp_the_ground(0.2 + (shock_counter_drone_threshold - shock_counter) / (shock_counter_max - shock_counter_drone_threshold));	
	}
	
	if (shock_counter <= 0)
	{
		shock_counter = shock_counter_max;
		image_index = 1
		with (oPlayer)
		{
			if (row == 0)
				force_down = 20;	
		}
		ShakeScreen(10, 10);
		need_to_tumble = false;
	}
	else
	{
		image_index = 0;	
	}
}




image_speed = 0;
event_inherited();

if (!need_to_tumble)
{
	if (instance_exists(oGunMan) && oGunMan.opponent != undefined && instance_exists(oGunMan.opponent))
	{
		with (oGunMan.opponent)
		{
			if (row == 0)
			{
				other.need_to_tumble = true;	
			}
		}
	}
}

if (need_to_tumble)
{
	shock_counter--;
	
	if (instance_exists(oGunManDrone) && shock_counter <= shock_counter_drone_threshold)
	{
		oGunManDrone.stomp_the_ground((shock_counter_drone_threshold - shock_counter) / (shock_counter_drone_threshold));	
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
		with (oCamera)
		{
			need_to_refocus = true;
			refocus_position_x = x;			
			refocus_position_y = y;
		}
		ShakeScreen(25, 15);
		need_to_tumble = false;
	}
	else
	{
		image_index = 0;	
	}
}




image_speed = 0;
if (!instance_exists(player) || player == noone)
{
	instance_destroy();
}

appear_timer--;
if (appear_timer == 0)
{
	start = true;
	image_yscale *= 3.5 * scale;
	image_xscale = 1.2 * scale;
	
	//var _expanded_height = sprite_get_height(sThunder) * image_yscale;
	y = oGenerator.ground[row]// - _expanded_height;
}

if (start)
{
	exist_timer--;
	if (exist_timer == 0)
	{
		instance_destroy();	
	}
}

DamagePlayer(20, 0);

image_xscale *= -1;

x += oRoomControl.roomspeed * scale;

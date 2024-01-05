// Inherit the parent event
event_inherited();

timer--;
mask_index = sprite_index;

//Print(state, row, y, depth);

switch(state)
{
	default:
	case VineStates.Waiting:
		mask_index = sEmpty;
		if (y > ystart - 32 * scale)
		{
			y -= 1 * scale;
		}
		if (timer <= 0)
		{
			state = VineStates.Strike;
		}
	break;
	case VineStates.Strike:
	
		ContactDamage(15, 0);
		if (bbox_bottom > ystart)
		{
			y -= 5 * scale;
		}
		else
		{
			y = ystart - sprite_get_height(sprite_index) * scale;
			state = VineStates.Idle;
			timer = retract_wait_time;
		}
	break;
	case VineStates.Idle:
		ContactDamage(10, 0);
		if (hp < 1)
		{
			timer -= ((1 - hp) * 10) / (oDifficultyController.bosses_defeated / 2 + 1);
			hp = 1;
		}
		if (timer <= 0)
		{
			state = VineStates.Retract;
		}
	break;
	case VineStates.Retract:
		y += 3 * scale;
		if (y > ystart)
		{
			instance_destroy();	
		}
	break;
}


/*
if (strike_timer <= -strike_timer_max)
{
	instance_destroy();
}
else if (strike_timer <= -strike_timer_max / 2)
{
	image_index = 0;
}	
else if (strike_timer <= 0)
{
	image_index = 1;
	ContactDamage(10, 0);
}

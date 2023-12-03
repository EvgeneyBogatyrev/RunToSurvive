// Inherit the parent event
event_inherited();

strike_timer--;

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

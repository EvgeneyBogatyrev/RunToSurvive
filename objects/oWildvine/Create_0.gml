// Inherit the parent event
event_inherited();
enum VineStates
{
	Waiting,
	Strike,
	Idle,
	Retract
}

state = VineStates.Waiting;

strike_wait_time = 1.5 * 60;
retract_wait_time = 1.5 * 60;

timer = strike_wait_time;

image_speed = 0;
vine_count = irandom_range(3,5);

vine_index = [];

for (var _i = 0; _i < vine_count; _i++)
{
	vine_index[_i] = irandom(image_number - 1);
}


hp = 1;

damage = GetStats("Wildvine");
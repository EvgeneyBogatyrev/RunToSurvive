/// @description
event_inherited();

enum EyeStates
{
	SEEK,
	CHASE
}

hp = 2;
state = EyeStates.SEEK;
dir = 1;

normal_speed = 1;
charged_speed = 3;

direction = 45 * irandom_range(0, 7)
speed = normal_speed;

offset = 25;

charge_counter_max = 90;
charge_counter = charge_counter_max;

saved_angle = 0;

damage = GetStats("Pandora's eye")

player = noone;

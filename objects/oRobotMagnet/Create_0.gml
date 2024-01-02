// Inherit the parent event
event_inherited();

host = undefined;

enum MagnetStates
{
	INACTIVE,
	ROTATING,
	ACTIVE,
}

state = MagnetStates.INACTIVE;

inactive_angle = 160;
image_angle = inactive_angle;


inactive_timer_max = 15 * 60;
inactive_timer = inactive_timer_max;

player = undefined;

angle_threshold = 10;
saved_angle = -1;

cur_replica = undefined;

gun_point_x = 36 - 6;
gun_point_y = 0;
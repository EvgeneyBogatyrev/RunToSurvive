// Inherit the parent event
event_inherited();

enum ShootingRobotStates
{
	ENTER,
	SHOOT,
	BACK
};

state = ShootingRobotStates.ENTER;

hp = 100;
walkspeed = 5;
shooting_threshold = 50;
rotation_speed = 1;


shooting_offset_x = 45 - 95;
shooting_offset_y = 114 - 70;
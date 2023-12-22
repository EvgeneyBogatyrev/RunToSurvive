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
walkspeed = 3;
shooting_threshold = 50;
rotation_speed = 1;


shooting_offset_x = 20 - 52;
shooting_offset_y = 52 - 14;
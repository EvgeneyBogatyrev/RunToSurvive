// Inherit the parent event
event_inherited();

enum FlyingRobotStates
{
	MOVE,
	ATTACK
};

state = FlyingRobotStates.MOVE;

hp = 100;
walkspeed = 5;

attack_timer_max = 120;
attack_timer = attack_timer_max;

start_angle = 15;
amount = 10;
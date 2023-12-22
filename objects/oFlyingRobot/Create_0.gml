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

attack_timer = 120;
attack_timer_max_move = 30;
attack_timer_max_attack = 120;


start_angle = 15;
amount = 10;
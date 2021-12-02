/// @description

event_inherited();

enum ChasingStumpState
{
	CHASE,
	STOP,
	VICTORY
};


maxhp = 50;
hp = maxhp;

walkspeed = 6;
jumpspeed = 12;

state = UniversalStates.INTRO;
intro_timer_max = 1.3 * 60;
intro_timer = intro_timer_max;
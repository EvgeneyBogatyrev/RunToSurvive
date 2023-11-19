/// @description
event_inherited();

enum RobotStates
{
	STAND,
	RUSH,
};

state = UniversalStates.INTRO;

hp = 20;

cum_hp = hp;
cum_hp_max = cum_hp;

maxhp = hp;

//Intro
intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;
phase = get_timer();

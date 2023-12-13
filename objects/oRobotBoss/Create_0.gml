/// @description
event_inherited();

enum RobotBossStates
{
	IDLE
};

state = UniversalStates.INTRO;

hp = 10 + 2 * oDifficultyController.bosses_defeated;

cum_hp = hp;
cum_hp_max = cum_hp;

maxhp = hp;

//Intro
intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;
phase = get_timer();
magnitude = 10;

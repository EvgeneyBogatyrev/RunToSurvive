/// @description
event_inherited();

enum RobotBossStates
{
	IDLE,
	WAIT_FOR_ROBOT,
	ROBOT,
};

state = UniversalStates.INTRO;

air_hp = 1 + 1 * oDifficultyController.bosses_defeated;
robot_hp = 20 + 2 * oDifficultyController.bosses_defeated;

hp = air_hp; 


cum_hp = air_hp + robot_hp;
cum_hp_max = cum_hp;

maxhp = hp;

//Intro
intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;
phase = get_timer();
magnitude = 10;


//Dying 
chosen_robot = undefined;


//Robot
change_speed_timer_max = 3 * 60;
change_speed_timer = 0;
walkspeed = 12;

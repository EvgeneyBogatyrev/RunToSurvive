/// @description
event_inherited();

enum RobotBossStates
{
	IDLE,
	WAIT_FOR_ROBOT,
	ROBOT,
	SHIP,
};

state = UniversalStates.INTRO;

air_hp = 10 + 1 * oDifficultyController.bosses_defeated;
robot_hp = 20 + 2 * oDifficultyController.bosses_defeated;
ship_hp = 10 + 1 * oDifficultyController.bosses_defeated;

hp = air_hp; 


cum_hp = air_hp + robot_hp + ship_hp;
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
change_speed_timer_max = 0.5 * 60;
change_speed_timer = 0;
walkspeed = 12;

// Ship
roomspeed_acc = 4;
saved_roomspeed = undefined;
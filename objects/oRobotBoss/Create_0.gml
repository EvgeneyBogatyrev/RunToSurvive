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

air_hp = 10 + 1 * oDifficultyController.bosses_defeated * GetStats("Increase hp");
robot_hp = 20 + 2 * oDifficultyController.bosses_defeated * GetStats("Increase hp");
ship_hp = 20 + 2 * oDifficultyController.bosses_defeated * GetStats("Increase hp");

if (global.DEBUG)
{
	air_hp = 1;
	robot_hp = 1;
	ship_hp = 1;
}

hp = air_hp; 


cum_hp = air_hp + robot_hp + ship_hp;
cum_hp_max = cum_hp;

maxhp = hp;
prev_hp = hp;

damaged = false;

loot_profile_ids = [ROBOT_LOOT_INUMBER];

//Intro
intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;
phase = get_timer();
magnitude = 10;

screen_image_tick = 0;
screen_image_offset = 6;
screen_image_change_counter_max = 45;
screen_image_change_counter = screen_image_change_counter_max;
screen_image_offset_x = 28 - 62;
screen_image_offset_y = 22 - 39;
draw_screen = true;

trail = undefined;


//Dying 
chosen_robot = undefined;


//Robot
change_speed_timer_max = 0.5 * 60;
change_speed_timer = 0;
walkspeed = 12;
walk_from_behind = false;

// Ship
roomspeed_acc = 4;
saved_roomspeed = undefined;

magnet_offset_x = 104 - 1;
magnet_offset_y = 88 - 186;

damage_second_phase = GetStats("Robot boss 2nd phase");
damage_third_phase = GetStats("Robot boss 3rd phase");
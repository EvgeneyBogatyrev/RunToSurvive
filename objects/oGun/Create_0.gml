enum Gun 
{
	DRILL, 
	STANDART_GUN,
	SHOTGUN,
	POWERGUN,
	ROCKET_LAUNCHER,
	LIFESTEAL_GUN,
	REAL_SHOTGUN,
	ELECTRIC_GUN
};

enum DrillStates
{
	FREE,
	ATTACK,
};

//Overall
current_gun = Gun.STANDART_GUN;

if (global.DEBUG)
{
	current_gun = Gun.LIFESTEAL_GUN;
}

last_gun = Gun.DRILL;
recall = 0;
shoot = false;
cost = 0;
damage = 0;

//Drill
drill_state = DrillStates.FREE;
hit_by_attack = ds_list_create();

//Shotgun
shotgun_timer_max = 5;
shotgun_timer = 5;
shotgun_times = 0;

//Powergun
shoot_hold = false;
temp_bullets = 0;
increase = true;

//Rocket Launcher
launcher_times = 0;
launcher_timer_max = 10;
launcher_timer = launcher_timer_max;

//electricity
electricity_obj = undefined;

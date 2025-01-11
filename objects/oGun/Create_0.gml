enum Gun 
{
	BASIC_REPEATER,
	KICKS_N_PUNCHES,
	STEAMPUNK_HAMMER,
	SHORTRANGE_BLASTER,
	DRILL, 
	STANDART_GUN,
	SHOTGUN,
	POWERGUN,
	ROCKET_LAUNCHER,
	LIFESTEAL_GUN,
	REAL_SHOTGUN,
	ELECTRIC_GUN,
	CHARGING_GUN,
};




enum MeleeStates
{
	IDLE,
	ATTACK,
};

//Overall
current_gun = Gun.STANDART_GUN;

if (global.DEBUG)
{
	current_gun = Gun.CHARGING_GUN;
}

secondary = false;

recoil = 0;
shoot = false;
cost = 0;
damage = 0;


//Combo Punch


//Hammer
hammer_state = MeleeStates.IDLE;
dir_lock = 0;
swing_dir = 1;
swing_time = 40;

//Drill
drill_state = MeleeStates.IDLE;
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

//CHARGING Gun
charge_timer = 0;


/// @description
event_inherited();

enum DelverStates
{
	MAGE,
	INSECT,
	VICTORY
};

state = UniversalStates.INTRO;

mage_hp = 20;
insect_hp = 40;

maxhp = mage_hp;
hp = maxhp;

//Intro
intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;
phase = get_timer();
magnitude = 30;
acceleration = 0.1;

//Mage
attack_timer_max = 3 * 60;
attack_timer = attack_timer_max;
zap = noone;

//Insect
player = noone;
insect_speed = 2.5;
desired_row = 0;
offset = 100;
rest_timer_max = 12 * 60;
rest_timer = rest_timer_max;
stop_time = 2 * 60;
flying_forward = false;
dir_update_max = 30;
dir_update = dir_update_max;
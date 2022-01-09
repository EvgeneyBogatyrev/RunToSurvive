/// @description
event_inherited();

enum PandoraStates
{
	BOX,
	GAUNTLET,
	EYE
}

hp = 6;
maxhp = 6;

box_hp = 10;
gauntlet_hp = 20;
eye_hp = 10;

cum_hp = box_hp + gauntlet_hp + eye_hp;
cum_hp_max = cum_hp;

state = UniversalStates.INTRO;
sprite_index = sPandoraBoxBlink;

flyspeed = 6;
eyes_amount = 10;

//Box state
intro_timer = 6 * 60;
spawn_timer_max = 2.5 * 60;
spawn_timer = spawn_timer_max;
spawn_frame = 5;
spawn_intro = 1;

magnitude = 50;
phase = get_timer();

//Gauntlet state
designation = -1;
acceleration = 0.05;
gauntlet_speed = 15;
y_offset = 20 + BLOCKSIZE;
direction_changed = false;
spawn_counter_max = 3; //Must be odd
spawn_counter = spawn_counter_max;

//Eye state
start = false;
alive_timer_max = 15 * 60;
alive_timer = alive_timer_max;
eye_spawn_counter = 5;
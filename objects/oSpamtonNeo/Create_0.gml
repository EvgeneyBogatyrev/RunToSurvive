/// @description Insert description here
// You can write your code in this editor

enum SpamtonStates
{
	HEART,
	PIPIS,
};




// Inherit the parent event
event_inherited();

state = UniversalStates.INTRO;

maxhp = 50 + 5 * oDifficultyController.bosses_defeated * GetStats("Increase hp");

if (global.DEBUG)
{
	maxhp = 100;	
}

cum_hp_max = maxhp;
cum_hp = cum_hp_max;

row = 0;

change_row_timer_max = 2 * 60;
change_row_timer = change_row_timer_max;

y_to_go = y;
scale_to_be = 1;

intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;

heart_angle = 0;
heart_angle_min = 90 + 30;
heart_angle_max = 90 + 120;

heart_length_min = 3;
heart_length_max = 150;
heart_length = heart_length_min;
increase_length = false;

draw_x = x;
draw_y = y;

heart_x = x;
heart_y = y;


gun_rotation_min = 190;
gun_rotation_max = 250;
gun_rotation_add = 1;
gun_rotation = gun_rotation_min;

pipis_shot_timer_max = 1.5 * 60;
pipis_shot_timer = pipis_shot_timer_max;

arm_right_x = 0;
arm_right_y = 0;
arm_len = 83;

change_attack_timer_max = 30 * 60;
change_attack_timer = change_attack_timer_max;

miniboss_spawn_timer_max = 2 * 60;
miniboss_spawn_timer = miniboss_spawn_timer_max;

first_pipis = true;


heart_hp_max = 5;
heart_hp = heart_hp_max;

prev_hp = hp;

//loot_profile_id = ROBOT_LOOT_INUMBER;



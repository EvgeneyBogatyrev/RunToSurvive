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

maxhp = 100;
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



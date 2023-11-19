/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

enum StumpTreeStates
{
	APPEAR,
	IDLE,
	DEAD
};


max_hp = 60;
hp = max_hp;
cum_hp_max = max_hp;
cum_hp = cum_hp_max;

stump_spam_timer_max = 60;
stump_spam_timer = stump_spam_timer_max;

spawn_offset = 100;


state = StumpTreeStates.APPEAR;

row = 1;

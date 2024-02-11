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


max_hp = 45 + 5 * oDifficultyController.bosses_defeated * GetStats("Increase hp");

if (global.DEBUG)
{
	max_hp = 1;	
}

hp = max_hp;
cum_hp_max = max_hp;
cum_hp = cum_hp_max;

stump_spam_timer_max = 60;
stump_spam_timer = stump_spam_timer_max;

spawn_offset = 100;

damage = GetStats("Tree boss");


state = StumpTreeStates.APPEAR;

loot_profile_id = TREE_LOOT_INUMBER;

row = 1;

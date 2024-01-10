/// @description
event_inherited();

enum DelverStates
{
	MAGE,
	INSECT,
	VICTORY
};

state = UniversalStates.INTRO;

mage_hp = 20 + 3 * oDifficultyController.bosses_defeated  * GetStats("Increase hp");
insect_hp = 40 + 6 * oDifficultyController.bosses_defeated * GetStats("Increase hp");

if (global.DEBUG)
{
	mage_hp = 1;
	insect_hp = 1;
}

cum_hp = mage_hp + insect_hp;
cum_hp_max = cum_hp;

maxhp = mage_hp;
hp = maxhp;

loot_profile_id = DELVER_LOOT_INUMBER;

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

// Insect attack
insect_attack_cooldown = 0;
insect_attack_cooldown_max = 45;

player_distance_threshold = 50; // attack activation distance
attack_sprite = sDelverInsectAttack; // attack sprite
attack_image_index = 6;  // when to deal damage
attack_x_shift = 50; // damage circle shift relative to local x
attack_radius = 40; // damage circle radius

slash_damage = GetStats("Delver's slash");


// Debug
visualise_circle = false;

/// @description

event_inherited();

enum ChasingStumpState
{
	CHASE,
	STOP,
	VICTORY
};


maxhp = 100 + 5 * oDifficultyController.bosses_defeated * GetStats("Increase hp");
hp = maxhp;

slowspeed = 3;
walkspeed = 6;
fastspeed = 8;
jumpspeed = 12;

fast_timer_max = 200;
fast_timer = 0;

current_speed = walkspeed;

crowned = true;

state = UniversalStates.INTRO;
intro_timer_max = 5 * 60;
intro_timer = intro_timer_max;

first_phase_timer = 30 * 60;
first_phase_timer_max = 30 * 60;

if (global.DEBUG)
{
	//first_phase_timer = 1;
	//first_phase_timer_max = 1;
	maxhp = 10;
}

shown_hp = 0;
healthbar_alpha = 0;

not_give_score = false;

image_blend = c_green;

damage = GetStats("Chasing stump");
can_be_knockbacked = true;
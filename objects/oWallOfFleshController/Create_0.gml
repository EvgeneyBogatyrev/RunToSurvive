// Inherit the parent event
event_inherited();

enum WallOfFleshStates
{
	BATTLE,	
}

// global
maxhp = 65 + 10 * oDifficultyController.bosses_defeated;
hp = maxhp;
cum_hp = maxhp;
cum_hp_max = maxhp;


state = UniversalStates.INTRO;

oGenerator.preprocess_forbidden_obstacles = true;  //To increase number of structures


// intro
intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;

// dead
slide_back_speed = 2;
loot_profile_ids = [WALL_LOOT_INUMBER];


// Create eyes and mouth
further_eye = undefined;

for (var _row = 0; _row < 3; ++_row)
{
	if (_row == 1)
	{
		with (Create(x, oGenerator.ground[_row], oWallOfFleshMouth, _row))
		{
			depth += 1;	
			controller = other.id;
		}
	}
	else
	{
		with (Create(x, oGenerator.ground[_row], oWallOfFleshEye, _row))
		{
			depth -= 4;
			controller = other.id;
			if row == 0 other.further_eye = id;
		}
	}
}

// Destroy all halfbosses
with (oHalfBossParent)
{
	hp = 0;	
	not_give_score = true;
}

StopRoom();
event_inherited();

enum HalfBossStates
{
	IDLE = -382913,
	TRIGGERED = -819421,
	BATTLE = -48932,
	INACTIVE = -12345,
	KNOCKBACKED = -98765
};

notice_player = Create;
player = noone;
saved_state = HalfBossStates.IDLE;

shown_hp = 0;
maxhp = 0;

healthbar_alpha = 0;
not_give_score = false;

real_image_alpha = 1;

ground_calibrated = false;
can_be_knockbacked = true;
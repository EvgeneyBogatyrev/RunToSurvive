event_inherited();

enum HalfBossStates
{
	IDLE,
	TRIGGERED,
	BATTLE,
	INACTIVE
};

notice_player = Create;
player = noone;
saved_state = HalfBossStates.IDLE;

shown_hp = 0;
maxhp = 0;

healthbar_alpha = 0;
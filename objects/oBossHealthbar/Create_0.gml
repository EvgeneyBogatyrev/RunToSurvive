boss = undefined;

state = BossHBStates.HIDDEN;

hp_visual = 0;

y_offset = 0;
y_offset_max = 124;

enum BossHBStates
{
	HIDDEN,
	SLIDE_IN,
	SLIDE_OUT,
	NORMAL,
	LOCKED,
	
}
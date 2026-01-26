boss = undefined;

state = BossHBStates.HIDDEN;


y_offset = 0;
y_offset_max = 320;

enum BossHBStates
{
	HIDDEN,
	SLIDE_IN,
	SLIDE_OUT,
	NORMAL,
	LOCKED,
	
}
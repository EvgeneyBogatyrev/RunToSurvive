switch state
{
	case BossHBStates.HIDDEN:
		if boss != undefined and instance_exists(boss)
		{
			state = BossHBStates.SLIDE_IN;
			hp_visual = boss.cum_hp;
		}
	break;
	case BossHBStates.SLIDE_IN:
		if y_offset >= y_offset_max
		{
			y_offset = y_offset_max;
			state = BossHBStates.NORMAL;
		}
		y_offset += 1;
	break;	
	case BossHBStates.NORMAL:
		if (boss == undefined || !instance_exists(boss))
		{
			state = BossHBStates.SLIDE_OUT;
			exit;
		}
		if (abs(hp_visual - boss.cum_hp) >= 1)	
			hp_visual = ApproachTo(hp_visual, boss.cum_hp);
	break;
	case BossHBStates.LOCKED:
		//NOTHING
	break;
	case BossHBStates.SLIDE_OUT:
		if y_offset <= 0
		{
			y_offset = 0;
			state = BossHBStates.HIDDEN;
		}
		y_offset -= 1;
	break;
}

Print(state, boss)
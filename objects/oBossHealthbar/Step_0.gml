switch state
{
	case BossHBStates.HIDDEN:
		if boss != undefined and instance_exists(boss)
		{
			state = BossHBStates.SLIDE_IN;
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
	case BossHBStates.LOCKED:
		//NOTHING
	break;
	case BossHBStates.SLIDE_OUT:
		if y_offset >= y_offset_max
		{
			y_offset = y_offset_max;
			state = BossHBStates.HIDDEN;
		}
		y_offset -= 1;
	break;
}
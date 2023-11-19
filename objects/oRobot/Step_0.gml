/// @description

switch (state)
{
	case UniversalStates.INTRO:
		hsp = max_hsp;
		
		if (x > oCamera.x) state = RobotStates.RUSH;
		
		break;
	
	case RobotStates.RUSH:
		
		break;
	
	default:
		Raise("Wrong Delver state\n");
		break;
}

x += hsp;

event_inherited();
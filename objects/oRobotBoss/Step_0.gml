/// @description

switch (state)
{
	case UniversalStates.INTRO:
		var _acc = (abs(x - oCamera.center) / oCamera.view_w_half) > 0.5 ? 0.7 : 0.1;
		y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
		x = lerp(x, oCamera.center + sin((get_timer() - phase) / 500000) * magnitude, _acc);
		xspeed = 0.001;
	
		hp = maxhp;
		cum_hp = cum_hp_max;
		
		intro_timer--;
		if (intro_timer == 0)
		{
			state = RobotBossStates.IDLE;	
			Create(x, y, oRobotSpawner, 0);
		}
		break;
	
	case RobotBossStates.IDLE:
		var _acc = (abs(x - oCamera.center) / oCamera.view_w_half) > 0.5 ? 0.7 : 0.1;
		y = ystart + sin((get_timer() - phase) / 250000) * magnitude;
		x = lerp(x, oCamera.center + sin((get_timer() - phase) / 500000) * magnitude, _acc);
		xspeed = 0.001;
		
		if (hp <= 0)
		{
			global.score += 100;
			oRoomControl.gamestate = GameState.NORMAL;
			GetStandartRoomProperties();
			instance_destroy(oRobotSpawner);	
			instance_destroy();	
		}
		
		break;
	
	default:
		Raise("Wrong Robot boss state\n");
		break;
}


event_inherited();
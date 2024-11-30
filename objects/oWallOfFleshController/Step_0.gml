// Inherit the parent event
event_inherited();

if (!instance_exists(oPlayer))
{
	state = UniversalStates.VICTORY;	
}

switch (state)
{
	case UniversalStates.INTRO:
		hp = maxhp;
		cum_hp = cum_hp_max;
		
		intro_timer--;
		if (intro_timer == 0)
		{
			state = WallOfFleshStates.BATTLE;	
		}
		x = oWallOfFleshMouth.x;
		
		break;
		
	case WallOfFleshStates.BATTLE:
		x = oWallOfFleshMouth.x;
		if (hp <= 0 && state != UniversalStates.DEAD)
		{
			state = UniversalStates.DEAD;
			
			global.score += 100;
			oRoomControl.gamestate = GameState.LOOT;
			oGenerator.preprocess_forbidden_obstacles = false;
			GetStandartRoomProperties();
		}
		break;
		
	case UniversalStates.DEAD:
		x -= slide_back_speed;
		if (x < oCamera.left - 500)
		{
			// Destroy every part
			
			with (oWallOfFleshEye)
			{
				instance_destroy();	
			}
			
			
			with (oWallOfFleshMouth)
			{
				instance_destroy();	
			}
			instance_destroy();	
		}
		break;
		
	case UniversalStates.VICTORY:
		x -= slide_back_speed;
		break;
}





/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

// Inherit the parent event
event_inherited();

if (go_back)
{
	x -= 2;	
}

if (hp <= 0 && state != UniversalStates.DEAD)
{
	state = UniversalStates.DEAD;
	x = oWallOfFleshMouth.x;
	with (oWallOfFleshMovement)
	{
		go_back = true;	
	}
	go_back = true;
	oRoomControl.gamestate = GameState.LOOT;
}

if (state == UniversalStates.DEAD)
{
	if (x < oCamera.left - 500)
	{
		for (var _i = 0; _i < instance_number(oWallOfFleshMovement); ++_i)
		{
			with (instance_find(oWallOfFleshMovement, _i))
			{
				instance_destroy();	
			}
		}
		with (oWallOfFleshMouth)
		{
			instance_destroy();	
		}
		//ResumeRoom();
		oGenerator.preprocess_forbidden_obstacles = false;
		GetStandartRoomProperties();
		instance_destroy();	
	}
}
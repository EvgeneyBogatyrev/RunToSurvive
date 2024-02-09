///@desc If players have lost
function LevelEnd()
{
	global.show_title = false;
	
	with (oCamera)
	{
		focus = CameraFocus.ROW2;

		
		mode = CameraMode.STATIC;
	
		follow = Create(x, y, oFollow, 2);	
	}
	
	oRoomControl.gamestate = GameState.LOOT;
	
	with (oEnemyParent)
	{
		state = UniversalStates.VICTORY;	
	}
	
	
	
	ShowEndScreen();
	
	if (global.score > global.highscore)
	{
		global.highscore = global.score;
		SaveGame();
	}
	
	//room_goto(rMenu);
}

function ShowEndScreen()
{
	Create(0, 0, oDeathScreen, 0);
}
///@desc If players have lost
function LevelEnd()
{
	if (global.score > global.highscore)
	{
		global.highscore = global.score;
		SaveGame();
	}
	global.show_title = false;
	
	with (oCamera)
	{
		focus = CameraFocus.ROW2;

		
		mode = CameraMode.STATIC;
	
		follow = Create(x, y, oFollow, 2);	
	}
	
	ShowEndScreen();
	
	//room_goto(rMenu);
}

function ShowEndScreen()
{
	Create(0, 0, oDeathScreen, 0);
}
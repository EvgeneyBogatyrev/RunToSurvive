/// @description

if (oRoomControl.gamestate == GameState.NORMAL)  timer = ApproachTo(timer, 0);

if (timer == 0 && oRoomControl.gamestate == GameState.NORMAL)
{
	var _new_boss;
	do
	{
		_new_boss = choose("Pandora", "Delver");//, "ChasingStump");
	} until (_new_boss != last_boss);
	
	switch (_new_boss)
	{
		case "Pandora":
			SummonPandora();
			break;
		case "Delver":
			SummonDelver();
			break;
		case "ChasingStump":
			SummonChasingStump();
			break;
	}
	last_boss = _new_boss;
	
	timer = max_timer;
	oRoomControl.gamestate = GameState.BOSS;
}
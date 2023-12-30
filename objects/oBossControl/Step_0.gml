/// @description

if (oRoomControl.gamestate == GameState.NORMAL)  timer = ApproachTo(timer, 0);

if (timer == 0 && oRoomControl.gamestate == GameState.NORMAL && !instance_exists(oBossLoot))
{
	var _new_boss = "Delver";
	do
	{
		_new_boss = choose("Robot", "Pandora", "Delver", "ChasingStump");//, 
	} until (_new_boss != last_boss);
	if (global.DEBUG)
	{
		_new_boss = "Robot";
	}
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
		case "Robot":
			SummonRobot();
			break
	}
	last_boss = _new_boss;
	
	timer = max_timer;
	oRoomControl.gamestate = GameState.BOSS;
}
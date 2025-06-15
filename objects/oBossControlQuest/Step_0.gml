/// @description

if (oRoomControl.gamestate == GameState.NORMAL || oRoomControl.gamestate == GameState.BATTLE)
	timer = ApproachTo(timer, 0);

if (timer == 0 && oRoomControl.gamestate == GameState.NORMAL && oQuests.quest_completed)
{
	if (array_length(bosses_array) == 0)
	{
		bosses_array = InitBossesArray(previous_bosses_array);
		previous_bosses_array = bosses_array;
	}
	
	var _new_boss = bosses_array[0];
	var _new_bosses_array = [];
	for (var i = 1; i < len(bosses_array); ++i)
	{
		_new_bosses_array[i - 1] = bosses_array[i];
	}
	bosses_array = _new_bosses_array;
	
	//var _new_boss = "Delver";
	//do
	//{
	//	_new_boss = choose("Robot", "Pandora", "Delver", "ChasingStump");//, 
	//} until (_new_boss != last_boss);
	//if (global.DEBUG)
	//{
	//	_new_boss = "WallOfFlesh";
	//}
	var _boss_summoned = true;
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
			break;
		case "Spamton":
			SummonSpamton();
			break;
		case "GunMan":
			SummonGunMan();
			break;
		case "WallOfFlesh":
			SummonWallOfFlesh();
			break;
		default:
			Print(_new_boss, "what the heck? who is this dude? invalid boss name");
			_boss_summoned = false;
			break;
	}
	last_boss = _new_boss;
	
	timer = int64(max_timer * random_range(0.95, 1.05));
	if (_boss_summoned)
	{
		oRoomControl.gamestate = GameState.BOSS;
		oQuests.SetNewQuest();
	}
}
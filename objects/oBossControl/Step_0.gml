/// @description

if (oRoomControl.gamestate == GameState.NORMAL)  timer = ApproachTo(timer, 0);

if (timer == 0 && oRoomControl.gamestate == GameState.NORMAL)
{
	if (array_length(tmp_bosses_array) == 0)
	{
		tmp_bosses_array = array_shuffle(bosses_array);	
		while (last_boss == tmp_bosses_array[0])
		{
			tmp_bosses_array = array_shuffle(bosses_array);
		}
	}
	
	var _new_boss = tmp_bosses_array[0];
	
	var _new_array = [];
	for (var i = 0; i < array_length(tmp_bosses_array) - 1; ++i)
	{
		_new_array[i] = tmp_bosses_array[i + 1];	
	}
	tmp_bosses_array = _new_array;
	
	//var _new_boss = "Delver";
	//do
	//{
	//	_new_boss = choose("Robot", "Pandora", "Delver", "ChasingStump");//, 
	//} until (_new_boss != last_boss);
	if (global.DEBUG)
	{
		_new_boss = "WallOfFlesh";
	}
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
	
	timer = max_timer;
	if (_boss_summoned)
	{
		oRoomControl.gamestate = GameState.BOSS;
	}
}
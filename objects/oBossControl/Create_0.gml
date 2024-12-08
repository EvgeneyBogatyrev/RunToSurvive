/// @description
max_timer = 60 * 60;
timer = 15 * 60;

if (global.DEBUG)
{
	timer = 5;	
	max_timer = 5 * 60;
}

last_boss = "";

bosses_array = ["Robot", "Pandora", "Delver", "ChasingStump", "Spamton", "GunMan", "WallOfFlesh"];

banned_as_first_boss = ["Robot", "Pandora", "Spamton", "WallOfFlesh"];
banned_as_second_boss = ["Robot", "Spamton"];

tmp_bosses_array = array_shuffle(bosses_array);
while (true)
{
	var _OK = true;
	for (var i = 0; i < array_length(banned_as_first_boss); ++i)
	{
		if (tmp_bosses_array[0] == banned_as_first_boss[i])
		{
			_OK = false;
			break;
		}
	}
	
	for (var i = 0; i < array_length(banned_as_second_boss); ++i)
	{
		if (tmp_bosses_array[1] == banned_as_second_boss[i])
		{
			_OK = false;
			break;
		}
	}
	
	if (!_OK)
	{
		tmp_bosses_array = array_shuffle(bosses_array);
	}
	else
	{
		break;	
	}
}
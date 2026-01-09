/// @description
max_timer = 5 * 60 * 60;
timer = 5 * 60 * 60;

if (global.DEBUG)
{
	timer = 5// 5 * 60 * 60;	
	max_timer = 5 * 60;
}

level1_bosses = ["Delver", "GunMan"];
level2_bosses = ["ChasingStump", "Delver", "GunMan", "Pandora"];
level3_bosses = ["Robot", "Spamton", "WallOfFlesh"];

banned_as_first_boss = ["Robot", "Pandora", "Spamton", "WallOfFlesh",  "GunMan"];
banned_as_second_boss = ["Robot", "Spamton"];

previous_bosses_array = undefined;
last_boss = "";

oQuests.SetNewQuest();

function RandomArrayValue(array)
{
	return array[random_range(0, len(array))];	
}


function InitBossesArray(previous_bosses_array)
{
	var _bosses_array = ["Robot", "Pandora", "Delver", "ChasingStump", "Spamton", "GunMan", "WallOfFlesh"];

	tmp_bosses_array = array_shuffle(_bosses_array);
	if (previous_bosses_array != undefined)
	{
		return tmp_bosses_array;	
	}
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
			tmp_bosses_array = array_shuffle(_bosses_array);
		}
		else
		{
			break;	
		}
	}
	
	return tmp_bosses_array;
}

bosses_array = [];//InitBossesArray(previous_bosses_array);
//previous_bosses_array = bosses_array;



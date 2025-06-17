/// @description
max_timer = 5 * 60 * 60;
timer = 5 * 60 * 60;

if (global.DEBUG)
{
	//timer = 5 * 60 * 60;	
	//max_timer = 5 * 60;
}

level1_bosses = ["Delver", "GunMan"];
level2_bosses = ["ChasingStump", "Delver", "GunMan", "Pandora"];
level3_bosses = ["Robot", "Spamton", "WallOfFlesh"];

previous_bosses_array = undefined;
last_boss = "";

oQuests.SetNewQuest();

function RandomArrayValue(array)
{
	return array[random_range(0, len(array))];	
}


function InitBossesArray(previous_bosses_array)
{
	if (previous_bosses_array == undefined)
	{
		while (true)
		{
			bosses_array = [RandomArrayValue(level1_bosses), RandomArrayValue(level2_bosses), RandomArrayValue(level3_bosses)];
			if (bosses_array[0] != bosses_array[1])
			{
				break;
			}
		}
	}
	else
	{
		var first_boss = RandomArrayValue(level1_bosses);
		while (first_boss == previous_bosses_array[0])
		{
			first_boss = RandomArrayValue(level1_bosses);	
		}
		
		var second_boss = RandomArrayValue(level2_bosses);
		while (second_boss == previous_bosses_array[1] || second_boss == first_boss)
		{
			second_boss = RandomArrayValue(level2_bosses);	
		}
		
		var third_boss = RandomArrayValue(level3_bosses);
		while (third_boss == previous_bosses_array[2])
		{
			third_boss = RandomArrayValue(level3_bosses);	
		}
		bosses_array = [first_boss, second_boss, third_boss];
	}
	return bosses_array;
}

bosses_array = [];//InitBossesArray(previous_bosses_array);
//previous_bosses_array = bosses_array;
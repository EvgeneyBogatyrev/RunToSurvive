/// @description
max_timer = 60 * 60;
timer = 15 * 60;

if (global.DEBUG)
{
	timer = 5;	
	max_timer = 5 * 60;
}

last_boss = "";

bosses_array = ["Robot", "Pandora", "Delver", "ChasingStump", "Spamton"];
tmp_bosses_array = array_shuffle(bosses_array);
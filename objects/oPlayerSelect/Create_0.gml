/// @description

number_of_characters = 4;

images = [sKyronImage, sLongHairImage, sSteamImage, sRoboImage];

number_of_players = global.multiplayer ? 0 : 1;
number_of_players_max = 4;

choices = [];
lock = [];
allowed_array = [];
allowed_hor_array = [];

colors = [c_red,  c_aqua, c_yellow, c_green];
if (!global.multiplayer)
{
	player_colors[0] = colors[0];
	colors = [c_aqua, c_yellow, c_green, c_red];
}

for (var i = 0; i < number_of_players_max; ++i)
{
	choices[i] = i;	
	lock[i] = false;
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}


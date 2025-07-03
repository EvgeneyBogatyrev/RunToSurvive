/// @description
max_time = 20 * 60;
time = max_time;
scale = 1;

index = STDGUN_INUMBER;
host = oPlayer;

offset = 60;


allowed_to_move = true;
allowed_to_move_hor = true;
allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i < 5; ++i)
{
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}
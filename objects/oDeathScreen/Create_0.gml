StopRoom();

time_of_the_run = oRoomControl.run_timer;

allowed_to_move = true;
allowed_to_move_hor = true;

allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i <= 4; ++i)
{
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}
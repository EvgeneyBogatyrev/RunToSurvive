button[0] = "CONTINUE";
button[1] = "RESTART";
button[2] = "EXIT";
//button[3] = "EXIT";
cursor_position = 0;
max_cursor = 2;

MODE = "Menu";
ebutton[0] = "BACK";

paused = false;

allowed_to_move = true;
allowed_to_move_hor = true;

allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i <= 4; ++i)
{
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}
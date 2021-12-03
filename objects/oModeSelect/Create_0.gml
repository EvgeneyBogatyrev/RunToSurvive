//Initialize cursor position
cursor_position = 0;

//Set default buttons
dbutton[0] = "SINGLEPLAYER";
dbutton[1] = "MULTIPLAYER";
dbutton[2] = "BACK";

_length = array_length(dbutton);

//Set gamepad
allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i < 5; ++i)
{
	choices[i] = i;	
	lock[i] = false;
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}
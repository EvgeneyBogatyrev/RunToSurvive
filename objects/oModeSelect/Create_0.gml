//Initialize cursor position
cursor_position = 0;

//Set default buttons
dbutton[0] = "STORYMODE";
dbutton[1] = "INFINITY MODE";
dbutton[2] = "COLLECTION";
dbutton[3] = "BACK";

_length = array_length_1d(dbutton);

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
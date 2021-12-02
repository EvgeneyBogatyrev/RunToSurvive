///@description Input control

//Setcursor position
cursor_position = 0;


//Set default buttons
dbutton[0] = "MULTIPLAYER: " + (global.multiplayer ? "On" : "Off");
dbutton[1] = "PLAYER 1 INPUT: " + StateToText(input_type[0]);
dbutton[2] = "PLAYER 2 INPUT: " + StateToText(input_type[1]);
dbutton[3] = "REFRESH GAMEPADS";
dbutton[4] = "BACK";

//Set drawing buttons 
button[0] = dbutton[0];
button[1] = dbutton[1];
button[2] = dbutton[2];
button[3] = dbutton[3];
button[4] = dbutton[4];

_length = array_length_1d(button);

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
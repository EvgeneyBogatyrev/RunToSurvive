/// @description Initialization.

//set cursor position
cursor_position = 1;

//set default buttons
dbutton[0] = "NEW GAME";
dbutton[1] = "CONTINUE";
dbutton[2] = "OPTIONS";
dbutton[3] = "EXIT";

//set drawing buttons
button[0] = dbutton[0];
button[1] = dbutton[1];
button[2] = dbutton[2];
button[3] = dbutton[3];

_length = array_length_1d(button);

//animation
x0 = room_width/2;
y0 = room_height/2 - 30;
alpha = 1;
y0_cur = room_height + 50;
yTitle_cur = -50;
centered = false;

if (!global.show_animation)
{
	alpha = 0;
	y0_cur = y0;
	yTitle_cur = 150;
}


//for gamepad
allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i < 5; ++i)
{
	choices[i] = i;	
	lock[i] = false;
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}

if (!global.show_title)
{
	global.show_title = true;
	instance_change(oModeSelect, true);	
}


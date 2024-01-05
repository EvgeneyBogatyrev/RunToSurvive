///@description Input control

//Set cursors
cursor_position = 0;
switcher_position = 0;

music_position = global.music_gain * 10;
sound_position = global.sound_gain * 10;

character_position = 0;
switch (global.character)
	{
		case "Kyron":
			character_position = 0;
			break;
		case "LongHair":
			character_position = 1;
			break;
		case "Steampunk":
			character_position = 2;
			break;
		case "Cyber":
			character_position = 3;
			break;
	}

switch(global.display_width)
{
	
	case HIGH_DEFINITION_WIDTH : 
		switcher_position = 2;
		break;	
	
	case STANDART_DEFINITION_WIDTH :
		switcher_position = 1;
		break;	
	
	case LOW_DEFINITION_WIDTH : 
		switcher_position = 0;
		break;	
}

//Set resolutions
resolutionW = [LOW_DEFINITION_WIDTH, STANDART_DEFINITION_WIDTH, HIGH_DEFINITION_WIDTH];
resolutionH = [LOW_DEFINITION_HEIGHT, STANDART_DEFINITION_HEIGHT, HIGH_DEFINITION_HEIGHT];

//Set default buttons
dbutton[0] = "SCREEN RESOLUTION:" 
dbutton[1] = string(global.display_width) + "X" + string(global.display_height);
dbutton[2] = "MUSIC VOLUME: " + string(100 * global.music_gain) + "%";
dbutton[3] = "SOUND VOLUME: " + string(100 * global.sound_gain) + "%";
dbutton[4] = "Character: " + global.character;
dbutton[5] = "BACK";

//Set drawing buttons
button[0] = dbutton[0];
button[1] = dbutton[1];
button[2] = dbutton[2];
button[3] = dbutton[3];
button[4] = dbutton[4];
button[5] = dbutton[5];

_cursor_length = array_length(button);
_switcher_length = array_length(resolutionW);

//Set drawing
x0 = room_width / 2;
y0 = room_height / 2
need_to_center = false;

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
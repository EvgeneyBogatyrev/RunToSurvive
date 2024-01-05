if (need_to_center)
{
	need_to_center = false;
	window_center();
}


#region Input 

	var _keys = Input(InputTypes.MENU);

	var _left = _keys[0];
	var _right = _keys[1];
	var _up = _keys[2];
	var _down = _keys[3];
	var _OK = _keys[4];
	var _back = _keys[5];
	
#endregion

#region Cursors control

	if (_up)   
	{
		cursor_position--;
		if (cursor_position == 1)  cursor_position--;
	}
	if (_down)
	{
		cursor_position++;
		if (cursor_position == 1)  cursor_position++;
	}
	

	if (cursor_position == 0)
	{
		if (_left)  switcher_position --;
		if (_right) switcher_position ++;
	}
	else
	{
		switch(global.display_width)
		{
			case 1280 : 
				switcher_position = 2;
				break;	
	
			case 1024 :
				switcher_position = 1;
				break;	
	
			case 800 : 
				switcher_position = 0;
				break;	
		}	
	}
		
	
	if (cursor_position == 2)
	{
		if (_left)  music_position --;
		if (_right) music_position ++;
	}
	
	if (cursor_position == 3)
	{
		if (_left)  sound_position --;
		if (_right) sound_position ++;
	}
	
	if (cursor_position == 4)
	{
		if (_left)  character_position --;
		if (_right) character_position ++;
	}
	
	if (cursor_position >= _cursor_length)      cursor_position = 0;
	if (cursor_position < 0)                    cursor_position = _cursor_length - 1;
	
	if (switcher_position >= _switcher_length)  switcher_position = 0;
	if (switcher_position < 0)                  switcher_position = _switcher_length - 1;
	
	if (music_position > 10)  music_position = 10;
	if (music_position < 0)   music_position = 0;
	
	if (sound_position > 10)  sound_position = 10;
	if (sound_position< 0)    sound_position = 0;
	
	if (character_position > 3)  character_position = 0;
	if (character_position < 0)  character_position = 3;
	
	global.music_gain = music_position / 10;
	global.sound_gain = sound_position / 10;
	
	switch (character_position)
	{
		case 0:
			global.character = "Kyron";
			break;
		case 1:
			global.character = "LongHair";
			break;
		case 2:
			global.character = "Steampunk";
			break;
		case 3:
			global.character = "Cyber";
			break;
	}

#endregion

#region Set buttons to draw

	dbutton[0] = "SCREEN RESOLUTION:"
	dbutton[1] = string(resolutionW[switcher_position]) + "X" + string(resolutionH[switcher_position]);
	dbutton[2] = "MUSIC VOLUME: " + string(100 * global.music_gain) + "%";
	dbutton[3] = "SOUND VOLUME: " + string(100 * global.sound_gain) + "%";
	dbutton[4] = "Character: " + global.character;
	dbutton[5] = "BACK";


	for(var i = 0; i < _cursor_length; i++)
		button[i] = dbutton[i];

#endregion

#region Button description

	if (_OK)
	{
		switch(cursor_position)
		{
			case 0:
			//Resize screen
			
				if (window_get_fullscreen())
					break;
			
				global.display_width = resolutionW[switcher_position];
				global.display_height = resolutionH[switcher_position];
			
				display_set_gui_size(global.display_width, global.display_height);	
				window_set_size(global.display_width, global.display_height);
				surface_resize(application_surface, global.display_width, global.display_height);
				need_to_center = true;
				
				SaveGame();
				break;
				
			case 2:
			case 3:
			case 4:
			break;			
		
			case 5 : 
			//Go back to menu
				button = [];
				dbutton = [];
				_cursor_length = 0;
				_switcher_length = 0;
				instance_change(oMainMenu, true);
				with (oMainMenu) 
				{
					center_timer = -1;		
				}
				SaveGame();
				break;
		}
	}
	if (_back)
	{
		//Go back to menu
		button = [];
		dbutton = [];
		_cursor_length = 0;
		_switcher_length = 0;
		instance_change(oMainMenu, true);
		with (oMainMenu) 
		{
			center_timer = -1;		
		}
		SaveGame();
	}

#endregion

#region Sounds

	if (_left or _right or _up or _down)  audio_play_sound(soSelect, 1, false);	
	if (_OK)                              audio_play_sound(soConfirm, 1, false);
		
#endregion
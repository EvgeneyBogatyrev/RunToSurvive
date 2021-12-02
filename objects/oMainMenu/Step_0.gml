/// @description Switch between buttons.

#region Animation

	x0 = room_width/2;
	
	if (global.show_animation)
	{
		alpha = Increase(alpha, 0, -0.007);

		if (y0_cur > y0)  y0_cur = lerp(y0_cur, y0 - 80, 0.01);
		else              y0_cur = y0;
	
		if (yTitle_cur < 150)   yTitle_cur = lerp(yTitle_cur, 200, 0.01);
		else                    yTitle_cur = 150;
	}
	else
	{
		alpha = 0;
		y0_cur = y0;
		yTitle_cur = 150;
	}
		
#endregion

#region Input

	var _keys = Input(InputTypes.MENU);

	//if (_alpha > 0.5)
	//	_keys = [0, 0, 0, 0, 0];

	var _left = _keys[0];
	var _right = _keys[1];
	var _up = _keys[2];
	var _down = _keys[3];
	var _OK = _keys[4];
	
#endregion

#region Cursor controll

	if (_up)   cursor_position --;
	if (_down) cursor_position ++;

	if (cursor_position >= _length)  cursor_position = 0;
	if (cursor_position < 0)             cursor_position = _length - 1;
	
#endregion

#region Import buttons to draw them

	for(var i = 0; i < _length; i++)  button[i] = dbutton[i];

#endregion

#region Button descriptions

	if (_OK)
	{
		global.show_animation = false;
		switch(cursor_position)
		{
			
			case 0:
			//Erase all data
		
				if (file_exists(global.filename))  file_delete(global.filename);	
			
				var _w = global.display_width;
				var _h = global.display_height;
				
				LoadGame();

				global.display_width = _w;
				global.display_height = _h;
				
				SaveGame();	
				
				button = [];
				dbutton = [];
				_length = 0;
				
				instance_change(oModeSelect, true);
				break;	
			
		
			case 1: 
			//go to Mode Select
				button = [];
				dbutton = [];
				_length = 0;
				instance_change(oModeSelect, true);
				break;
		
			case 2: 
			//Go to Options
				button = [];
				dbutton = [];
				_length = 0;
				instance_change(oOptions, true);
				break;
		
			case 3:
			//Shut the game down
				game_end();
				break;
			
			default:
				break;
		}
	}
	
#endregion

#region Sounds

	if (_left or _right or _up or _down)  audio_play_sound(soSelect, 1, false);	
	if (_OK)                              audio_play_sound(soConfirm, 1, false);
		
#endregion
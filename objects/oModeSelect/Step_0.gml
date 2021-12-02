#region Input

	var _keys = Input(InputTypes.MENU);

	var _left = _keys[0];
	var _right = _keys[1];
	var _up = _keys[2];
	var _down = _keys[3];
	var _OK = _keys[4];

#endregion

#region Cursor control

	if (_up)   cursor_position --;
	if (_down) cursor_position ++;
	
	if (cursor_position >= _length)  cursor_position = 0;
	if (cursor_position < 0)        cursor_position = _length - 1;
	
#endregion

#region Buttons description

	if (_OK)
	{
		switch(cursor_position)
		{
			case 0:
			//Go to Level selection
				instance_change(oPlayerSelect, true);
				break;
			
			case 1:
			//Infinity mode
				instance_change(oPlayerSelect, true);
				break;
			
			case 2:
			//Go to collection
				//dbutton = [];
				//button = [];
				//_length = 0;
				//room_to_go = oModeSelect;
				//instance_change(oCollectionControl, true);
				break;
			
			case 3:
			//Go to main menu
				dbutton = [];
				button = [];
				_length = 0;
				instance_change(oMainMenu, true);
				break;
		}
	}

#endregion

#region Sounds

	if (_left or _right or _up or _down)  audio_play_sound(soSelect, 1, false);	
	if (_OK)                              audio_play_sound(soConfirm, 1, false);
		
#endregion
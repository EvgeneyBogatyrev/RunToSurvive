
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
	if (cursor_position < 0)         cursor_position = _length - 1;
		
#endregion

#region Set drawing buttons

	dbutton[0] = "MULTIPLAYER: " + (global.multiplayer ? "On" : "Off");
	dbutton[1] = "PLAYER 1 INPUT: "+ StateToText(input_type[0]);
	dbutton[2] = "PLAYER 2 INPUT: "+ StateToText(input_type[1]);

	for(var i = 0; i < _length; i++)
		button[i] = dbutton[i];

#endregion

#region Button description

	if (_OK)
	{
		switch(cursor_position)
		{
			case 0:
			//Multiplayer On/Off
				if (global.multiplayer)  global.multiplayer = false;
				else                     global.multiplayer = true;
				break;
		
			case 1:
			//Player1 input type
				switch(input_type[0])
				{
					case InputTypes.KEYBOARD: input_type[0] = InputTypes.GAMEPAD0; break
					case InputTypes.GAMEPAD0: input_type[0] = InputTypes.GAMEPAD1; break;
					case InputTypes.GAMEPAD1: input_type[0] = InputTypes.KEYBOARD; break;
				}
				break;
		
			case 2:
			//Player2 input type
				switch(input_type[1])
				{
					case InputTypes.KEYBOARD: input_type[1] = InputTypes.GAMEPAD0; break
					case InputTypes.GAMEPAD0: input_type[1] = InputTypes.GAMEPAD1; break;
					case InputTypes.GAMEPAD1: input_type[1] = InputTypes.KEYBOARD; break;
				}
				break;
		
			case 3:
			//Refresh gamepads
				
				break;
			
		
			case 4:
			//Back to menu
				if (input_type[0] != input_type[1])
				{
					button = [];
					dbutton = [];
					_length = 0;
					instance_change(oModeSelect, true);
				}
				break;
		
		}
	}

#endregion

#region Sounds

	if (_left or _right or _up or _down)  audio_play_sound(soSelect, 1, false);	
	if (_OK)                              audio_play_sound(soConfirm, 1, false);
		
#endregion
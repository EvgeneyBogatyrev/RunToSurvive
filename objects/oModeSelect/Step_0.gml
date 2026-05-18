#region Input

	var _keys = Input(InputTypes.MENU);

	var _left = _keys[0];
	var _right = _keys[1];
	var _up = _keys[2];
	var _down = _keys[3];
	var _OK = _keys[4];
	var _back = _keys[6];
	
#endregion

#region Cursor control

	if (items_mode)
	{
		var _device = SelectGamepad(0);
		
		var _gp_grid_left = false;
		var _gp_grid_right = false;
		var _gp_grid_up = false;
		var _gp_grid_down = false;
		var _gp_left = false;
		var _gp_right = false;
		var _gp_jump = false;
		var _gp_shoot = false;
		var _gp_shoot_pressed = false;
		var _gp_back = false;
		
		if (_device != -1)
		{
			_gp_grid_left = gamepad_button_check_pressed(_device, gp_padl);
			_gp_grid_right = gamepad_button_check_pressed(_device, gp_padr);
			_gp_grid_up = gamepad_button_check_pressed(_device, gp_padu);
			_gp_grid_down = gamepad_button_check_pressed(_device, gp_padd);
			_gp_left = gamepad_axis_value(_device, gp_axislh) < -0.35;
			_gp_right = gamepad_axis_value(_device, gp_axislh) > 0.35;
			_gp_jump = gamepad_button_check_pressed(_device, gp_face1);
			_gp_shoot = gamepad_button_check(_device, gp_face3);
			_gp_shoot_pressed = gamepad_button_check_pressed(_device, gp_face3);
			_gp_back = gamepad_button_check_pressed(_device, gp_face2) || gamepad_button_check_pressed(_device, gp_start);
		}
		
		var _grid_left = keyboard_check_pressed(ord("A")) || _gp_grid_left;
		var _grid_right = keyboard_check_pressed(ord("D")) || _gp_grid_right;
		var _grid_up = keyboard_check_pressed(ord("W")) || _gp_grid_up;
		var _grid_down = keyboard_check_pressed(ord("S")) || _gp_grid_down;
		var _cursor_moved = ItemsMenuMoveCursor(_grid_left, _grid_right, _grid_up, _grid_down);
		
		var _preview_left = keyboard_check(vk_left) || _gp_left;
		var _preview_right = keyboard_check(vk_right) || _gp_right;
		var _preview_jump = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_space) || _gp_jump;
		var _preview_shoot = keyboard_check(ord("X")) || _gp_shoot;
		var _preview_shoot_pressed = keyboard_check_pressed(ord("X")) || _gp_shoot_pressed;
		var _items_back = keyboard_check_pressed(vk_escape) || _gp_back;
		
		ItemsMenuStepPreview(_preview_left, _preview_right, _preview_jump, _preview_shoot, _preview_shoot_pressed);
		
		if (_items_back)
		{
			items_mode = false;
			cursor_position = 2;
			audio_play_sound(soSelect, 1, false);
		}
		
		if (_cursor_moved) audio_play_sound(soSelect, 1, false);
		exit;
	}

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
				number_of_players = 1;
				names[0] = global.character;
				input_type[0] = InputTypes.ANY; // FIX!
				room_goto(rPlay);
				break;
			
			case 1:
			//Infinity mode
				instance_change(oPlayerSelect, true);
				break;
						
			case 2:
			//Item catalogue
				items_mode = true;
				ItemsMenuResetPreview();
				items_last_cursor = -1;
				break;
						
			case 3:
			//Go to main menu
				dbutton = [];
				button = [];
				_length = 0;
				instance_change(oMainMenu, true);
				with (oMainMenu) 
				{
					center_timer = -1;		
				}
				break;
		}
	}
	
	if (_back)
	{
		dbutton = [];
		button = [];
		_length = 0;
		instance_change(oMainMenu, true);
		with (oMainMenu) 
		{
			center_timer = -1;		
		}
	}
	
#endregion

#region Sounds

	if (_left or _right or _up or _down)  audio_play_sound(soSelect, 1, false);	
	if (_OK)                              audio_play_sound(soConfirm, 1, false);
		
#endregion

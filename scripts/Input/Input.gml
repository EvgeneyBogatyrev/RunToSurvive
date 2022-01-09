///@desc Input(type);
///@args type
function Input(argument0) {

	/// Input from the keyboard or gamepad.

	var _input_type = argument0;
	var
	_left = 0, 
	_right = 0, 
	_up = 0, 
	_down = 0, 
	_jump = 0, 
	_shoot = 0, 
	_press_shoot = 0, 
	_accept = 0,
	_cancel = 0,
	_pause = 0, 
	_show_inv = 0,
	_left_press = 0,
	_right_press = 0;

	switch(_input_type)
	{

		case InputTypes.KEYBOARD : 
			_left = keyboard_check(vk_left);
			_right = keyboard_check(vk_right);
			_up = keyboard_check_pressed(vk_up);
			_down = keyboard_check_pressed(vk_down);
			_jump = keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_space);
			_shoot = keyboard_check_pressed(ord("X"));
			_press_shoot = keyboard_check(ord("X"));
			_accept = keyboard_check_pressed(ord("A"));
			_cancel = keyboard_check_pressed(ord("S"));
			_pause = keyboard_check_pressed(vk_escape);
			_show_inv = keyboard_check_pressed(vk_control);
			_left_press = keyboard_check_pressed(vk_left);
			_right_press = keyboard_check_pressed(vk_right);
		
			return [_left, _right, _up, _down, _jump, _shoot, _press_shoot, _accept, _cancel, _pause, _show_inv, _left_press, _right_press];
			break;	
	
		case InputTypes.GAMEPAD0 : 
		case InputTypes.GAMEPAD1 :
		case InputTypes.GAMEPAD2 :
		case InputTypes.GAMEPAD3 :
	
			var _device = SelectGamepad(_input_type - InputTypes.GAMEPAD0);
		
			if (abs(gamepad_axis_value(_device, gp_axislv)) < 0.3)  allowed_to_move = true;
			if (abs(gamepad_axis_value(_device, gp_axislh)) < 0.3)  allowed_to_move_hor = true;
		
	
			_up = (((gamepad_axis_value(_device, gp_axislv) < -0.7) && allowed_to_move)||(gamepad_button_check_pressed(_device, gp_padu)));
			_down = (((gamepad_axis_value(_device, gp_axislv) > 0.7) && allowed_to_move)||(gamepad_button_check_pressed(_device, gp_padd)));
			_left = (((gamepad_axis_value(_device, gp_axislh) < -0.7))||(gamepad_button_check(_device, gp_padl)));
			_right = (((gamepad_axis_value(_device, gp_axislh) > 0.7))||(gamepad_button_check(_device, gp_padr)));
			_jump = gamepad_button_check_pressed(_device, gp_face1);
			_shoot =  gamepad_button_check_pressed(_device, gp_face3);			
			_press_shoot =  gamepad_button_check(_device, gp_face3);
			_accept = gamepad_button_check_pressed(_device, gp_face4);
			_cancel = gamepad_button_check_pressed(_device, gp_face2);
			_pause = gamepad_button_check_pressed(_device, gp_start);
			_show_inv = gamepad_button_check_pressed(_device, gp_shoulderrb);
			_left_press = (((gamepad_axis_value(_device, gp_axislh) < -0.7) && allowed_to_move_hor)||(gamepad_button_check_pressed(_device, gp_padl)));
			_right_press = (((gamepad_axis_value(_device, gp_axislh) > 0.7) && allowed_to_move_hor)||(gamepad_button_check_pressed(_device, gp_padr)));
		
			if (_up or _down)     allowed_to_move = false;
			if (_left || _right)  allowed_to_move_hor = false;
		
			return [_left, _right, _up, _down, _jump, _shoot, _press_shoot, _accept, _cancel, _pause, _show_inv, _left_press, _right_press];
			break;
	
		case InputTypes.MENU : 
		
			var _array = [];
		
			for (var i = 0; i < 5; ++i)
			{
				allowed_to_move = allowed_array[i];
				allowed_to_move_hor = allowed_hor_array[i];
				_array[i] = Input(i + InputTypes.KEYBOARD);			
				allowed_array[i] = allowed_to_move;
				allowed_hor_array[i] = allowed_to_move_hor;
			}
		
			for (var i = 0; i < 5; ++i)
			{
				var _cur_array = _array[i];
				_left |= _cur_array[11];
				_right |= _cur_array[12];
				_up |= _cur_array[2];
				_down |= _cur_array[3];
				_jump |= (keyboard_check_pressed(vk_enter) || _cur_array[4]);
				_pause |= _cur_array[9];
			
			}
		
			return [_left, _right, _up, _down, _jump, _pause];
	

		case InputTypes.ANY: 
		
			var _array = [];
		
			for (var i = 0; i < 5; ++i)
			{
				allowed_to_move = allowed_array[i];
				allowed_to_move_hor = allowed_hor_array[i];
				_array[i] = Input(i + InputTypes.KEYBOARD);			
				allowed_array[i] = allowed_to_move;
				allowed_hor_array[i] = allowed_to_move_hor;
			}
		
			var _return_array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		
			for (var i = 0; i < 5; ++i)
			{
				for (var j = 0; j < array_length(_array[i]); ++j)
				{
					_return_array[j] |= _array[i][j]
				}
			}
		
			return _return_array;
				
	
		default : 
			Raise("Input type is undefined\n");
			break;	
	}





}

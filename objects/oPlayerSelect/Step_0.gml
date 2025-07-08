/// @description

var _global_OK = 0
var _global_cancel = 0;

for (var i = 0; i < number_of_players; ++i)
{
	var _input_type = input_type[i];
	
	if (_input_type != InputTypes.KEYBOARD && !gamepad_is_connected(SelectGamepad(_input_type - InputTypes.GAMEPAD0)))
	{
		var _tmp_color = player_colors[i];
		for (var c = 3; c >= 1; --c)
		{
			colors[c] = colors[c - 1]	
		}
		colors[0] = _tmp_color;
		number_of_players--;
	}
	
	switch(_input_type)
	{
		case InputTypes.KEYBOARD:
			var _left = keyboard_check_pressed(vk_left);
			var _right = keyboard_check_pressed(vk_right);
			var _OK = keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_space);
			_global_OK |= keyboard_check_pressed(vk_enter);
		break;
		default:
			var _device = SelectGamepad(_input_type - InputTypes.GAMEPAD0);
			var _left = gamepad_button_check_pressed(_device, gp_padl);
			var _right = gamepad_button_check_pressed(_device, gp_padr);
			var _OK = gamepad_button_check_pressed(_device, gp_face1);
			_global_OK |= gamepad_button_check_pressed(_device, gp_start);
			
			if (allowed_array[i])
			{
				_left |= gamepad_axis_value(_device, gp_axislh) < -0.7;
				_right |= gamepad_axis_value(_device, gp_axislh) > 0.7;
			}
			
			if (_left || _right)  allowed_array[i] = false;
			
			if (abs(gamepad_axis_value(_device, gp_axislh)) < 0.3)  allowed_array[i] = true;
			
			
		break;
	}
	if (!lock[i])
	{
		if (_left)   choices[i]--;
		if (_right)  choices[i]++;
	}
	
	choices[i] = BoundBetween(choices[i], 0, number_of_characters - 1);
	
	if (_OK)
	{
		if (lock[i])
		{
			lock[i] = false;	
		}
		else
		{
		
			var _flag = true;
			for (var j = 0; j < number_of_players; ++j)
			{
				if (choices[j] == choices[i] && lock[j]) 
				{
					_flag = false;	
					break;
				}
			}
		
			if (_flag)
			{
				lock[i] = true;
				names[i] = GetNameFromIndex(choices[i]);
			}
		}
	}	
}

var _flag = _global_OK;
for (var i = 0; i < number_of_players; ++i)
{
	if (!lock[i])
	{
		_flag = false;
		break;
	}
}

if (_flag && number_of_players > 0)
{
	room_goto(rPlay);	
}

var _tmp_input_type = InputTypes.KEYBOARD;
for (var i = 0; i < gamepad_get_device_count() + 1; ++i)
{
	
	if (i > 0 &&  !gamepad_is_connected(SelectGamepad(i - 1)))  continue;
	
	if (_tmp_input_type == InputTypes.KEYBOARD)  _global_cancel |= keyboard_check_pressed(vk_escape);
	else                                         _global_cancel |= gamepad_button_check_pressed(SelectGamepad(i - 1), gp_select);
	
	var _keys = Input(_tmp_input_type);
	
	var _OK = _keys[4];
	var _cancel = (i > 0) ? gamepad_button_check_pressed(SelectGamepad(i - 1), gp_face2) : 0;
	if (i == 0)  _cancel = _keys[5];
	
	if ((_OK && number_of_players < 4) || (!global.multiplayer))
	{
		var _flag = true;
		for (var j = 0; j < number_of_players; ++j)
		{
			if (input_type[j] == _tmp_input_type)	
			{
				_flag = false;
				break;
			}
		}
		if (_flag)  
		{
			input_type[number_of_players] = _tmp_input_type;
			lock[number_of_players] = false;
			player_colors[number_of_players] = colors[0];
			
			for (var t = 0; t < 3; ++t)  colors[t] = colors[t + 1];
			colors[3] = player_colors[number_of_players];
			choices[number_of_players++] = 0;
		}
	}
	
	if (_cancel)
	{
		var _index_delete = -1;
		for (var j = 0; j < number_of_players; ++j)
		{
			if (input_type[j] == _tmp_input_type)  	
			{
				_index_delete = j;
				break;
			}
		}
		
		if (_index_delete != -1)
		{
			var _tmp_color = player_colors[_index_delete];
			for (var c = 3; c >= 1; --c)
			{
				colors[c] = colors[c - 1]	
			}
			colors[0] = _tmp_color;
			
			for (var m = _index_delete; m < number_of_players - 1; ++m)
			{
				input_type[m] = input_type[m + 1];
				choices[m] = choices[m + 1];
				lock[m] = lock[m + 1]; 
				player_colors[m] = player_colors[m + 1];
				
				if (lock[m])  names[m] = GetNameFromIndex(choices[m]);
			}
			number_of_players--;
		}
			
	}	
	
	_tmp_input_type++;
}

if (_global_cancel)  instance_change(oModeSelect, true);	



#region Input

	var _keys = Input(InputTypes.MENU);

	var _left = _keys[0];
	var _right = _keys[1];
	var _up = _keys[2];
	var _down = _keys[3];
	var _OK = _keys[4];
	var _back = _keys[6];
	 
#endregion

var _size = ds_list_size(current_menu.fields);

cursor_pos = (cursor_pos + _down - _up + _size) mod _size;

if (_OK)
{
	current_menu.InteractWithField(cursor_pos, 0);
	
	cursor_pos = 0;
}

if ((_left || _right) && current_menu.FieldIsSelection(cursor_pos))
{
	
}

if (_back)
{
	if (current_menu.is_main) game_end();
	else current_menu.GoBack();
}


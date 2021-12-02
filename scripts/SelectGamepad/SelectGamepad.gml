///@desc SelectGamepad(gp);
///@arg gamepad
function SelectGamepad(argument0) {

	/// Find connected gamepads and select one of them as an input type.

	var _index = argument0;

	var _list = ds_list_create();
	var _slots = gamepad_get_device_count();

	for (var i = 0; i < _slots; ++i)
	{
		if (gamepad_is_connected(i))
			ds_list_add(_list, i)
	}

	var _res = ds_list_find_value(_list, _index);

	ds_list_destroy(_list);

	if (_res == undefined) 
		return -1;
	else                 
		return _res;




}

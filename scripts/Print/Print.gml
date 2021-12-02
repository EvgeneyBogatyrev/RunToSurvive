///@desc printf(args...)
function Print() {

	var _line = "";

	for (var i = 0; i < argument_count; ++i)
	{
		_line += string(argument[i]);
		_line += " ";
	}

	show_debug_message(_line);


}

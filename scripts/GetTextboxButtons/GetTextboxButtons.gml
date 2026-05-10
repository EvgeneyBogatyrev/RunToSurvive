///@desc Get Buttons based on player`s input type
///@param input type
function GetTextboxButtons(argument0) {

	var _input_type = argument0;

	if (index < ROCKETBOOTS_INUMBER)
	{
		switch (_input_type)
		{
			case InputTypes.KEYBOARD:
				return "  A             S            D \n"
			case InputTypes.DEBUG_KEYBOARD_WASD:
				return "        E                    Q \n"
			case InputTypes.DEBUG_KEYBOARD_IJKL:
				return "        Y                    H \n"
			default:
				return "Shldr L       Shldr R        B \n";
		}
	}
	else
	{
		switch (_input_type)
		{
			case InputTypes.KEYBOARD:
				return "        A/S           D        \n";
			case InputTypes.DEBUG_KEYBOARD_WASD:
				return "         E            Q        \n";
			case InputTypes.DEBUG_KEYBOARD_IJKL:
				return "         Y            H        \n";
			default:
				return "   Shldr L/Shldr R     B       \n";
		}
	}


}

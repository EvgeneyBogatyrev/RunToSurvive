///@desc StateToText(state);
///@args state
function StateToText(argument0) {

	///Transform input states to text.

	switch(argument0)
	{
		case InputTypes.KEYBOARD : 
			return "keyboard";
	
		case InputTypes.GAMEPAD0 : 
			return "gamepad0";
	
		case InputTypes.GAMEPAD1 : 
			return "gamepad1";

		case InputTypes.DEBUG_KEYBOARD_WASD:
			return "debug keyboard WASD";

		case InputTypes.DEBUG_KEYBOARD_IJKL:
			return "debug keyboard IJKL";

		default : 
			Raise("Invalid input type\n");
			break;
	
	}


}

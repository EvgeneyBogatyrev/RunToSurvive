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

		default : 
			Raise("Invalid input type\n");
			break;
	
	}


}

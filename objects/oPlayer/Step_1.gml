/// @description

if (_input_type != InputTypes.KEYBOARD)
{
	if (!gamepad_is_connected(SelectGamepad(_input_type - InputTypes.GAMEPAD0)))  
	{
		if (instance_number(oPlayer) == 1)
		{
			LevelEnd();	
		}
		instance_destroy();	
		exit;
	}
}

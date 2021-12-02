/// @description

if (room == rMenu && !instance_exists(oAudioControl))  instance_create_layer(0, 0, "Instances", oAudioControl);

if (room == rMenu)
{
	var gamepad_amount = 0;
	for (var i = 0; i < gamepad_get_device_count(); ++i)
	{
		if (gamepad_is_connected(i))
		{
			gamepad_amount++;
		}
	}
	
	if (gamepad_amount > 0)  global.multiplayer = true;
	else                     global.multiplayer = false;
}
else
{
	if (number_of_players > 1)   global.multiplayer = true;	
	else                         global.multiplayer = false;
}
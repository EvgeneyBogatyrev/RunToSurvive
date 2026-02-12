/// @description

if (_input_type != InputTypes.KEYBOARD and _input_type != InputTypes.ANY)
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



if (name == "Cyber" && !init_cyber)
{
	init_cyber = true;
	bullets = max(hp, bullets);
	hp = bullets;
	maxbullets = max(maxhp, maxbullets);
	maxhp = maxbullets;
}


if (name == "Cyber")
{
	previous_bullets = min(bullets, maxbullets);
	previous_hp = min(hp, maxhp);
	
	previous_maxhp = maxhp;	
	previous_maxbullets = maxbullets;
}

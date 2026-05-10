/// @description

var _keyboard_input = _input_type == InputTypes.KEYBOARD
	|| _input_type == InputTypes.ANY
	|| _input_type == InputTypes.DEBUG_KEYBOARD_WASD
	|| _input_type == InputTypes.DEBUG_KEYBOARD_IJKL;

if (!_keyboard_input)
{
	if (!gamepad_is_connected(SelectGamepad(_input_type - InputTypes.GAMEPAD0)))  
	{
		if (instance_number(oPlayer) == 1)
		{
			last_damage_sprite = GetSpritesFromName(name).icon;
			last_damage_image = 0;
			RecordPlayerDeath(id, "lost connection to their controller", 0);
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

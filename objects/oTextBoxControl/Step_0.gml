/// @description

if (!instance_exists(player))
{
	instance_destroy();
	exit;
}

if (queue)
{
	if (instance_number(oTextBoxControl) == 1)
	{
		queue = false;	
	}
	else exit;
}

eq_left = 0;
eq_right = 0;
cancel = 0;

switch (player._input_type)
{
	case InputTypes.KEYBOARD:
		
		eq_left = keyboard_check_pressed(ord("A"));
		eq_right = keyboard_check_pressed(ord("S"));
		cancel = keyboard_check_pressed(ord("D"));
		
		break;
		
	default:
		var _device = SelectGamepad(player._input_type - InputTypes.GAMEPAD0);
		
		eq_left = gamepad_button_check_pressed(_device, gp_shoulderlb) || gamepad_button_check_pressed(_device, gp_shoulderl);
		eq_right = gamepad_button_check_pressed(_device, gp_shoulderrb) || gamepad_button_check_pressed(_device, gp_shoulderr);
		cancel = gamepad_button_check_pressed(_device, gp_face2);
		 
		 break;
		
	
}

if (eq_left || eq_right)
{
	if (index < ROCKETBOOTS_INUMBER)
	{
		var _pocket_index = 0;//(eq_left ? 0 : 1);
		switch (index)
		{
			case STDGUN_INUMBER:
				player.gun.current_gun = Gun.STANDART_GUN;
				player.gun.last_gun = Gun.DRILL;
				player.bullets = player.maxbullets;
				player.pocket[_pocket_index] = index;
				break;
			
			case POWERGUN_INUMBER:
				player.gun.current_gun = Gun.POWERGUN;
				player.gun.last_gun = Gun.DRILL;
				player.bullets = player.maxbullets;
				player.pocket[_pocket_index] = index;
				break;
			
			case SHOTGUN_INUMBER:
				player.gun.current_gun = Gun.SHOTGUN;
				player.gun.last_gun = Gun.DRILL;
				player.bullets = player.maxbullets;
				player.pocket[_pocket_index] = index;
				break;
			
			case ROCKET_LAUNCHER_INUMBER:
				player.gun.current_gun = Gun.ROCKET_LAUNCHER;
				player.gun.last_gun = Gun.DRILL;
				player.bullets = player.maxbullets;
				player.pocket[_pocket_index] = index;
				break;
			
				default:
					break;
		}
	}
	else
	{
		player.pocket[1] = index;		
	}
	
	
	instance_destroy();
}
else if (cancel)
{
	instance_destroy();	
}
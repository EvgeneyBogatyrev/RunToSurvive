if keyboard_check_pressed(192) || keyboard_check_pressed(vk_alt)
{
	enabled = !enabled;

	if enabled
	{
		instance_deactivate_all(true);
		instance_activate_object(oDrawer);
	}
	else
	{
		instance_activate_all();
		if ds_list_size(cmd_queue) > 0
		{
			for (var _i = 0; _i < ds_list_size(cmd_queue); _i++)
			{
				var _cmd = cmd_queue[|_i]
				switch (_cmd[0])
				{
					case "hp":
						oPlayer.hp = int64(_cmd[1]);
						break;
					case "ammo":
						oPlayer.bullets = int64(_cmd[1]);
						break;
					case "gun":
						oPlayer.gun.current_gun = int64(_cmd[1]);
						break;
					case "boss":
						array_insert(oBossControl.tmp_bosses_array, 0, _cmd[1]);		
						break;
					case "bossbegin":
						if len(_cmd) > 1 array_insert(oBossControl.tmp_bosses_array, 0, _cmd[1]);
						oBossControl.timer = 0;
						break;
					case "spawnitem":
						with (Create(oCamera.right, oGenerator.ground[0] - 100, oItemDrop, 0))
						{
							depth -= 2;
							image = int64(_cmd[1]);
						}
						break;
					case "roomspeed":
						with (oRoomControl)
						{
							roomspeed =  -int64(_cmd[1]);
							roomspeed_limit = int64(_cmd[1]);
						}
				}
			}
			ds_list_clear(cmd_queue);
		}
	}
	
	
	keyboard_string = "";
}


if !enabled return;



if keyboard_check_pressed(vk_enter)
{
	if (keyboard_string != "")
	{
		
		var _parse = string_split(keyboard_string, " ");
		
		switch _parse[0]
		{
			default:
				ds_list_add(history, "Unknown command.");
			break;
			case "gun":
			case "boss":
			case "bossbegin":
			case "spawnitem":
			case "hp":
			case "ammo":
			case "roomspeed":
				ds_list_add(cmd_queue, _parse);
			break;
				
		}
		
		ds_list_add(history, keyboard_string);
		ds_list_add(cmd_history, keyboard_string);
	}
	
	keyboard_string = "";
}
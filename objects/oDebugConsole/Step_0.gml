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
				var _cmd = ds_list_find_value(cmd_queue, _i);
				var _args = []
				array_copy(_args, 0, _cmd, 1, array_length(_cmd) - 1)
				
				commands[$ _cmd[0]](_args);
				
				//switch (_cmd[0])
				//{
				//	case "hp":
				//		oPlayer.hp = int64(_cmd[1]);
				//		break;
				//	case "ammo":
				//		oPlayer.bullets = int64(_cmd[1]);
				//		break;
				//	case "gun":
				//		oPlayer.gun.current_gun = int64(_cmd[1]);
				//		break;
				//	case "boss":
				//		array_insert(oBossControl.tmp_bosses_array, 0, _cmd[1]);		
				//		break;
				//	case "bossbegin":
				//		oBossControl.timer = 0;
				//		break;
				//	case "spawnitem":
				//		with (Create(oCamera.right, oGenerator.ground[0] - 100, oItemDrop, 0))
				//		{
				//			depth -= 2;
				//			image = int64(_cmd[1]);
				//		}
				//		break;
				//}
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
		
		//switch _parse[0]
		//{
		//	default:
		//		ds_list_add(history, "Unknown command.");
		//	break;
		//	case "gun":
		//	case "boss":
		//	case "bossbegin":
		//	case "spawnitem":
		//	case "hp":
		//	case "ammo":
		//		ds_list_add(cmd_queue, _parse);
		//	break;

				
		//}
		ds_list_insert(history, 0, keyboard_string);
		ds_list_insert(cmd_history, 0, keyboard_string);

		if struct_exists(commands, _parse[0])
		{
			ds_list_add(cmd_queue, _parse);
		}
		else
		{
			ds_list_insert(history, 0, "Unknown command.");

		}
		
		
	}
	
	keyboard_string = "";
}
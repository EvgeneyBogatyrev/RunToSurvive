if keyboard_check_pressed(192) || keyboard_check_pressed(vk_alt) || (enabled && keyboard_check_pressed(vk_escape))
{
	enabled = !enabled;

	if enabled
	{
		instance_deactivate_all(true);
		instance_activate_object(oDrawer);
		cmd_offset = -1;
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
			}
			ds_list_clear(cmd_queue);
		}
	}
	
	
	keyboard_string = "";
}


if !enabled return;


if keyboard_check_pressed(vk_up)
{
	cmd_offset += 1;
	cmd_offset = min(cmd_offset, ds_list_size(cmd_history) - 1);
	keyboard_string = cmd_history[|cmd_offset];
}

if keyboard_check_pressed(vk_down)
{
	cmd_offset -= 1;
	cmd_offset = max(cmd_offset, -1);
	if cmd_offset == -1
		keyboard_string = "";
	else
		keyboard_string = cmd_history[|cmd_offset];
}


if keyboard_check_pressed(vk_enter)
{
	cmd_offset = -1;
	if (keyboard_string != "")
	{
		
		var _parse = string_split(keyboard_string, " ");
		
		ds_list_insert(history, 0, keyboard_string);
		
		// Do not copy the command if it repeats the previous one
		var _cur_history_size = ds_list_size(cmd_history);
		if (_cur_history_size == 0 || keyboard_string != ds_list_find_value(cmd_history, 0))
		{
			ds_list_insert(cmd_history, 0, keyboard_string);
		}
		
		// Store only the first 100 entries
		while (ds_list_size(cmd_history) > history_size_limit)
		{
			ds_list_delete(cmd_history, ds_list_size(cmd_history) - 1);
		}

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

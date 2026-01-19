enabled = false;

history = ds_list_create();
cmd_history = ds_list_create();

cmd_queue = ds_list_create();

cmd_offset = -1;

commands = 
{
	"hp" : function (_args) { oPlayer.hp = int64(_args[0]) },
	"ammo" : function(_args) { oPlayer.bullets = int64(_args[0]) },
	"gun" : function(_args) { oPlayer.gun.current_gun = int64(_args[0]); },
	"boss" : function(_args) { array_insert(oBossControlQuest.bosses_array, 0, _args[0]); },
	"bossbegin" : function(_args) { oBossControlQuest.timer = 0; },
	"spawnitem" : function(_args) {
		with (Create(oCamera.right, oGenerator.ground[0] - 100, oItemDrop, 0))
		{
			depth -= 2;
			image = int64(_args[0]);
		}
	},
	"bossreward" : function(_args) {
		with (Create(oCamera.right, oGenerator.ground[0] - 100, oBossLoot, 0))
		{
			depth -= 2;
			profile = passive_items_profiles[int64(_args[0])];
		}
	},
	"revive" : function(_args) {
		with (oPlayer)
		{
			if (revival_number > 0)
			{
				var _player_name = names[revival[0]];
				var _player_inventory = revival_inventory[0];
			
				//var _times_resurrected = ds_map_find_value(oGenerator.times_resurrected, _player_name);			
				var _respawned_player = SpawnPlayerCharacter(revival[0], _player_name, x, y - 15 * scale, row);
			
				_respawned_player.hp = _respawned_player.maxhp / 2;// - 20 * _times_resurrected;			
				_respawned_player.prev_hp = _respawned_player.hp;
				_respawned_player.damaged = true;	
				_respawned_player.damage_timer = 5*30;
			
				//ds_map_(oGenerator.times_resurrected, _player_name, _times_resurrected + 1);

				_respawned_player.bullets = 0;
				_respawned_player.state = PlayerStates.NORMAL;
			
			
				_respawned_player.inventory = _player_inventory;
				//if (!ds_list_empty(_respawned_player.inventory))
				//	_respawned_player.item_picked_up = true;
				
				_respawned_player.onHurtEvent = GetItemActions(_respawned_player, "on_hurt");	
				_respawned_player.onJumpEvent = GetItemActions(_respawned_player, "on_jump");
				var _pickup_event = GetItemActions(_respawned_player, "on_pickup");
				for (var i = 0; i < array_length(_pickup_event); i++)
				{
					_pickup_event[i](_respawned_player);
				}
			
				for (var i = 0; i < revival_number - 1; ++i)
				{
					revival[i] = revival[i + 1];	
					revival_inventory[i] = revival_inventory[i + 1];	
					revival_guns[i] = revival_guns[i + 1];					
					revival_guns[i] = revival_powerups[i + 1];	
				
				}
				//pocket[1 + revival_number] = 0;
				revival_number -= 1;
			
			}
		}
	},
	
	"killplayer" : function(_args) {
		with(oPlayer)
		{
			if player_index == int64(_args[0])
			{
				hp = 0
			}
		}
	},
	
	"perf" : function(_args) {
		show_debug_overlay(	! is_debug_overlay_open())
	},
	
	"bb" : function(_args) { array_insert(oBossControlQuest.bosses_array, 0, _args[0]); oBossControlQuest.timer = 0; },
}



// Load history

filename = "console_history"; // Filename to save history to
key_name = "history"; // The key in saved ds map where history is stored

history_size_limit = 100; // max number of entries in history

if (file_exists(filename))
{
	var _saved_history = ds_map_secure_load(filename);
	if (_saved_history != -1)
	{
		cmd_history = ds_map_find_value(_saved_history, key_name);
	}
}



// Save history
save_history = function()
{
	var _ds_map_for_saving = ds_map_create();
	
	ds_map_add_list(_ds_map_for_saving, key_name, cmd_history);
	ds_map_secure_save(_ds_map_for_saving, filename);
	
	ds_map_destroy(_ds_map_for_saving);
}


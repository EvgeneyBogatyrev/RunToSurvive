function Piss()
{
	Print("piss");
}

function Shit()
{
	Print("shit");
}

function GiveItemToPlayer(_player, _item)
{
	ds_list_add(_player.inventory, _item);
	_player.item_picked_up = true;
}

function GetItemActions(_host, _event)
{
	var _actions = [];
	for (var _i = 0; _i < ds_list_size(_host.inventory); _i++)
	{
		var _item = ds_list_find_value(_host.inventory, _i);
		var hit_event = struct_exists(_item, _event) ? struct_get(_item, _event) : undefined;
		
		if (hit_event != undefined)
		{
			_actions[array_length(_actions)] = hit_event;
		}
	}
	
	return _actions;
}

globalvar passive_items_profiles;
passive_items_profiles = 
[
	{
		name : "Lightning Strike",
		icon_index : 0,
		on_hit : function(_host, _x_offset = 0)
		{
			var _chance = random(1);
			if (_chance < 0.2)
			{
				with(Create(_host.x + _x_offset, _host.y, oThunder, _host.row))
				{
					host = _host.host;
				}
			}
		}
	},
	
	{
		name : "Suspicious Eye",
		icon_index : 1,
		on_hurt : function(_host)
		{
			CreateOrbital(_host, 3, 32, oSuspiciousEye);
		}
	}
]


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
		var _action = struct_exists(_item, _event) ? struct_get(_item, _event) : undefined;
		
		if (_action != undefined)
		{
			_actions[array_length(_actions)] = _action;
		}
	}
	
	return _actions;
}

globalvar passive_items_profiles;
passive_items_profiles = 
[
	{
		name : "Lightning Strike",
		icon_index : DELVER_LOOT_INUMBER,
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
		},
		description : "Your bullets have a 20% chance to cause a lightning strike that deals 3 damage."
	},
	
	{
		name : "Suspicious Eye",
		icon_index : PANDORA_LOOT_INUMBER,
		on_hurt : function(_host)
		{
			CreateOrbital(_host, 3, 32, oSuspiciousEye);
		},
		description : "Whenever you take a hit, a floating eye that deals 5 damage appears around you."
	},
	
	{
		name : "Bullet pack",
		icon_index : ROBOT_LOOT_INUMBER,
		on_pickup : function(_host)
		{
			_host.maxbullets += 5;	
		},
		description : "Your maximum energy is increased by 5."
	},
	
	{
		name : "Mater sprout",
		icon_index : TREE_LOOT_INUMBER,
		on_jump : function(_host)
		{
			var _chance = random(1);
			if (_chance < 0.1)
			{
				var _heal_amount = 3;
				if (_host.pocket[1] == DOUBLEHEART_INUMBER)
				{
					_heal_amount *= 1.5;	
				}
				_host.hp += _heal_amount;
			}
		},
		description : "Whenever you jump, you have a 10% chance to heal by 3."
	},
	
	{
		name : "Dealmaker",
		icon_index : SPAMTON_LOOT_INUMBER,
		on_pickup : function(_host)
		{
			_host.damageBoost += 1;	
		},
		description : "Damage from your bullets is increased by 1."
	},
	{
		name : "Elite weapon",
		icon_index : GUNMAN_LOOT_INUMBER,
		on_pickup : function(_host)
		{
			var _guns = GetEliteGuns();			
			var _gun_images = GetEliteGunsImages();

			var _index = irandom_range(0, array_length(_guns) - 1);
			var _new_gun = _guns[_index];			
			var _new_gun_image = _gun_images[_index];


			_host.gun.current_gun = _new_gun;
			_host.pocket[0] = _new_gun_image;
			_host.bullets = _host.maxbullets;
			_host.shoot_hold = false;
		},
		description : "Equip a random fully-charged unique weapon when you pick this up or revive."
	},
	{
		name : "Damage boost",
		icon_index : WALL_LOOT_INUMBER,
		on_pickup : function(_host)
		{
			_host.base_drill_damage += 1;	
		},
		description : "Damage from your meele attecks is increased by 1."
	},
]


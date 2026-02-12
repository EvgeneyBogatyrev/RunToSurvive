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
	
	var _item_icon = pocket[1];
	
	var _trink = undefined
	var _trink_keys = struct_get_names(trinkets_profiles);
	for (var _i = 0; _i < len(_trink_keys); _i++)
	{
		var _key = _trink_keys[_i];
		var _value = struct_exists(trinkets_profiles, _key) ? struct_get(trinkets_profiles, _key) : undefined;
		
		if _value != undefined
		{
			if (_value.icon_index == _item_icon)
			{
				var _action = struct_exists(_value, _event) ? struct_get(_value, _event) : undefined;
		
				if (_action != undefined)
				{
					_actions[array_length(_actions)] = _action;
				}
				break;
			}
		}
		
	}
	
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

globalvar trinkets_profiles;

trinkets_profiles =
{
	rocket_boots : 
	{
		name : "Rocket boots",
		description : "Jump height increases.",
		icon_index : ROCKETBOOTS_INUMBER,
		on_pickup : function(_host)
		{
			_host.jump *= 1.2;
		}
	},
	lightning_boots :
	{
		item_name : "Lightninig boots",
		description : "Run speed increases.",
		icon_index : LIGHTNINGBOOTS_INUMBER,
		on_pickup : function(_host)
		{
			walkspeed = 10;
		}
	},
	forcefield :
	{	
		item_name : "Force field headphones",
		description : "Prevents the next hit you take.",
		icon_index : FORCEFIELD_INUMBER,
		on_pickup : function(_host)
		{
			_host.protected = true;
		}
	},
	energy_fist :
	{
		item_name : "Energy fist",
		description : "Increases energy gain from Charging Stations.",
		icon_index : ENERGYFIST_INUMBER,
		on_pickup : function(_host)
		{
			//??
		}
	},
	second_heart :
	{
		item_name : "Second heart",
		description : "Your healing is increased by 50%.",
		icon_index : DOUBLEHEART_INUMBER,
		on_pickup : function(_host)
		{
			//??
		}
	},
	random_melee :
	{
		item_name : "Crush",
		description : "Melee weapon deals additional 0-2 damage.",
		icon_index : CRUSH_INUMBER,
		on_pickup : function(_host)
		{
			_host.melee_damage += irandom_range(1, 3);
		}
	},
	extra_rocket : 
	{
		item_name : "Rocket Drone",
		description : "While shooting you can fire an aditional missile.",
		icon_index : DRONE_INUMBER,
		on_shoot : function(_host)
		{
			var _rnd_val = random_range(0, 100);
			if (_rnd_val < 33)
			{	
				Shoot(oAimProjectile, sRocket, 1 + host.damageBoost, 20, 8);
			}
		}

	},
	burn_bullets : 
	{
		item_name : "Incendium",
		description : "Your bullets causes burn.",
		icon_index : BURN_INUMBER,
		on_hit : function(_host, _victim)
		{
			//??
		}
	},
	refresher : 
	{
		item_name : "Refresher",
		description : "Whenever you kill an enemy, restore some HP and Energy.",
		icon_index : REFRACTOR_INUMBER,
		on_kill : function(_host, _player)
		{
			_player.hp += 5;
			_player.bullets += 3;
		}
	}
}

globalvar passive_items_profiles;
passive_items_profiles = 
[
	{
		name : "Lightning Strike",
		icon_index : DELVER_LOOT_INUMBER,
		on_hit : function(_host, _victim)
		{
			var _chance = random(1);
			if (_chance < 0.2)
			{
				with(Create(_host.x, _host.y, oThunder, _host.row))
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
		on_hurt : function(_host, _diff)
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
	
	/*{
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
	},*/
	
	{
		name : "Leaf Boots",
		icon_index : TREE_LOOT_INUMBER,
		on_pickup : function(_host)
		{
			_host.double_jump = true;	
		},
		description : "You can double jump."
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
			/*
			var _guns = GetEliteGuns();			
			var _gun_images = GetEliteGunsImages();

			var _index = irandom_range(0, array_length(_guns) - 1);
			var _new_gun = _guns[_index];			
			var _new_gun_image = _gun_images[_index];


			_host.gun.current_gun = _new_gun;
			_host.pocket[0] = _new_gun_image;
			_host.bullets = _host.maxbullets;
			_host.shoot_hold = false;
			*/
			
		},
		description : "Equip a random fully-charged unique weapon when you pick this up or revive."
	},
	{
		name : "Damage boost",
		icon_index : WALL_LOOT_INUMBER,
		on_pickup : function(_host)
		{
			_host.melee_damage += 1;	
		},
		description : "Damage from your meele attecks is increased by 1."
	},
	
	{
		name : "Tumble",
		icon_index : TUMBLE_LOOT_INUMBER,
		on_hit_meele : function(_host, _x_offset = 0)
		{
			var _chance = random(1);
			if (_chance < 0.5)
			{
				var _damage = 3;
				ShakeScreen(12, 12);
				with(oEnemyParent)
				{
					hp -= _damage;
					if (object_is_ancestor(object_index, oBossParent))
					{
						cum_hp -= _damage;
					}
					with (Create(x, y + 10 * scale, oDamageNumber, row))
					{
						damage = _damage;
					}				
				}
			}
		},
		description : "Your meele hits have 50% chance to cause an earthquake"
	},
	
	{
		name : "FARBAS",
		icon_index : FARBAS_LOOT_INUMBER,
		on_hurt : function(_host, _diff)
		{
			_host.damage_to_restore = _diff;
		},
		description : "Whenever you take a hit, launch a FARBAS protocol that will recover this damage."
	},
]


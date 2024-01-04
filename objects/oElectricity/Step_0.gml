/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

hit_timer--;
if (hit_timer <= 0)
{
	hit_timer = hit_timer_max;
	
	if (CheckCollisions(x, y, oEnemyParent, row))
	{
		var _victim = GetCollider(x, y, oEnemyParent, row);

		if (_victim.state != UniversalStates.DEAD && _victim.state != HalfBossStates.INACTIVE && _victim.hp > 0) 
		{
			_victim.hp -= damage;
			if object_is_ancestor(_victim.object_index, oBossParent)
			{
				_victim.cum_hp -= damage;	
			}
			display = true;
			_victim.hit_flash = 3;
		
			hit_an_enemy = true;
	
			if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
		}
	}

	if (place_meeting(x, y, oDelver) && oDelver.state == DelverStates.INSECT)
	{
		oDelver.hp -= damage;
		oDelver.cum_hp -= damage;
		oDelver.hit_flash = 3;
		display = true;
	
		hit_an_enemy = true;
	}

	if (display) with(Create(x, y, oDamageNumber, row))
	{
		damage = other.damage;
		depth = other.depth - 2;
	}

	if (hit_an_enemy)
	{
		//hit_events = [];
		//for (var _i = 0; _i < ds_list_size(host.inventory); _i++)
		//{
		//	var _item = ds_list_find_value(host.inventory, _i);
		//	var hit_event = struct_exists(_item, "on_hit") ? struct_get(_item, "on_hit") : undefined;
		//	Print(hit_event);
		//	if (hit_event != undefined)
		//	{
		//		hit_event(id, 82 * sign(image_xscale));
		//	}
		//}
	}	
	display =  false;
	hit_an_enemy = false;

}

// Inherit the parent event
event_inherited();


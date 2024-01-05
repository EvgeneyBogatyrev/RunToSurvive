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
			_victim.hit_flash = 3;
		
			with(Create(_victim.x, y, oDamageNumber, row))
			{
				damage = other.damage;
				depth = other.depth - 2;
			}
	
			if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
		}
	}

	if (place_meeting(x, y, oDelver) && oDelver.state == DelverStates.INSECT)
	{
		oDelver.hp -= damage;
		oDelver.cum_hp -= damage;
		oDelver.hit_flash = 3;
	
		with(Create(oDelver.x, y, oDamageNumber, row))
		{
			damage = other.damage;
			depth = other.depth - 2;
		}
	}


		
	

}

// Inherit the parent event
event_inherited();


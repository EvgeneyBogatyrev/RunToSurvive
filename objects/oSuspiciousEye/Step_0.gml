/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (!host.damaged)
{

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
		
	
			if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
			instance_destroy();	
		}
	}

	if (place_meeting(x, y, oDelver) && oDelver.state == DelverStates.INSECT)
	{

		oDelver.hp -= damage;
		oDelver.cum_hp -= damage;
		oDelver.hit_flash = 3;
		display = true;
		instance_destroy();	
	}
}
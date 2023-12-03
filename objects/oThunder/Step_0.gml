appear_timer--;
if (appear_timer == 0)
{
	start = true;
	image_yscale *= 3.5 * scale;
	image_xscale = 1.2 * scale;
	
	//var _expanded_height = sprite_get_height(sThunder) * image_yscale;
	y = oGenerator.ground[row]// - _expanded_height;
}

if (start)
{
	exist_timer--;
	if (exist_timer == 0)
	{
		instance_destroy();	
	}
}

if (!done && CheckCollisions(x, y, oEnemyParent, row))
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
	
		if (object_is_ancestor(_victim.object_index, oHalfBossParent) && _victim.state != UniversalStates.DEAD)  StartBattle(row, host, _victim);
		done = true;
	}
}

image_xscale *= -1;

x += oRoomControl.roomspeed * scale;

// Inherit the parent event
event_inherited();

for (var _player_count = 0; _player_count < instance_number(oPlayer); ++_player_count)
{
	var host = instance_find(oPlayer, _player_count);
	if (!CheckCollisions(x, y, host, row))
	{
		continue;	
	}
	if (!instance_exists(oReward))
	{
		continue;	
	}
	if (!oReward.can_player_get_reward(host))
	{
		continue;	
	}
	var _keys = Input(host._input_type);
	var _accept = _keys[7];

	var _next_gun = -1;
	if (item_index < ROCKETBOOTS_INUMBER)  _next_gun = GetGunStateFromID(item_index);

	if (_accept)
	{
		if (item_index == BATTERY_INUMBER)
		{
			var _bullet_gain = irandom_range(10, 15);
			host.bullets += _bullet_gain;
			if (host.pocket[1] == ENERGYFIST_INUMBER)
			{
				host.bullets += 2;	
			}
			oReward.player2reward[host] = true;
			instance_destroy();
			exit;
		}
		else if (item_index == HEARTH_INUMBER)
		{	
			var _healing_amount = irandom_range(20, 35);
			if (host.pocket[1] == DOUBLEHEART_INUMBER)
			{
				host.hp += _healing_amount * 1.5;	
			}
			else
			{
				host.hp += _healing_amount;	
			}
			oReward.player2reward[host] = true;
			instance_destroy();
			exit;
		}
		
		var _pocket_index;
		if (item_index < ROCKETBOOTS_INUMBER)
		{
			_pocket_index = 0;
			
			host.gun.current_gun = _next_gun;
			host.gun.secondary = false;
			
		}
		else	_pocket_index = 1;		
	

		host.pocket[_pocket_index] = item_index;
		oReward.player2reward[host] = true;
		instance_destroy();
	}
}
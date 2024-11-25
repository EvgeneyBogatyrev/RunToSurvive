
if (go_back)
{
	x -= 3;	
}

if (CheckCollisions(x + 100, y, oSolidParent, row))
{
	y -= 2;
	moving_down_counter = moving_down_counter_max;
}

moving_down_counter--;

if (moving_down_counter <= 0 && !CheckCollisions(x, y + 1, oSolidParent, row))
{
	y += 1;	
}

// Knockback player

for (var _i = 0; _i < instance_number(oPlayer); ++_i)
{
	var _player = instance_find(oPlayer, _i);	
	
	if (_player.x < x + 30 * scale)
	{
		if (!_player.damaged)
		{
			_player.damaged = true;	
			_player.damage_timer = 5*30;
		
			if (!_player.protected)  _player.hp -= contact_damage;
			else                    
			{
				_player.protected = false;
				if (_player.pocket[1] == FORCEFIELD_INUMBER)
				{
					_player.pocket[1] = 0;	
				}
			}
		}
		
		with (_player)
		{
			if CheckCollisions(x + 50 * scale, y - 10, oSolidParent, row)
			{
				KnockbackForce(_player, 200, -15);
			}
			else
			{
				KnockbackForce(_player, 200, 0);	
			}
		}
	}
}

event_inherited();


/// @description Angling
if (state == ItemDropStates.SPIN)
{
	
	var _player = noone;
	
	for (var i = 0; i < instance_number(oPlayer); ++i)
	{
		var _tmp = instance_find(oPlayer, i);
		if (_tmp.row == row && abs(_tmp.x - x) < sprite_width / 2 * scale)
		{
			_player = _tmp;
			break;
		}
	}
	
	if (_player != noone && _player.state != UniversalStates.DEAD) 
	{
		switch (image) 
		{
			case BATTERY_INUMBER:
				_player.bullets += irandom_range(1, 4);
				if (_player.pocket[1] == ENERGYFIST_INUMBER)
				{
					bullets += 2;	
				}
				break;
			
			case HEARTH_INUMBER:
				
				var _healing_amount = irandom_range(5, 15);
				_player.hp += _healing_amount;
				if (_player.pocket[1] == DOUBLEHEART_INUMBER)
				{
					_player.hp += 5;	
				}
				
				break;
				
			default:
			
				with (oItemIcon)
				{
					if (host == _player)  instance_destroy();
				}
			
				with (instance_create_layer(x, y, "Controllers", oItemIcon))
				{
					host = _player;
					index = other.image;
				}
				break;
			
			//case STDGUN_INUMBER:
			//	_player.gun.current_gun = Gun.STANDART_GUN;
			//	_player.gun.last_gun = Gun.DRILL;
			//	_player.bullets = _player.maxbullets;
			//	break;
			
			//case POWERGUN_INUMBER:
			//	_player.gun.current_gun = Gun.POWERGUN;
			//	_player.gun.last_gun = Gun.DRILL;
			//	_player.bullets = _player.maxbullets;
			//	break;
			
			//case SHOTGUN_INUMBER:
			//	_player.gun.current_gun = Gun.SHOTGUN;
			//	_player.gun.last_gun = Gun.DRILL;
			//	_player.bullets = _player.maxbullets;
			//	break;
			
			//default:
			//	break;
			
		
		}
		
		instance_destroy();
	}
}
/// @description
event_inherited();


if (CheckCollisions(x, y, oPlayer, row) && image_index == 0 && sprite_index == sCloningStation)
{
	with (GetCollider(x, y, oPlayer, row))  
	{
		if (revival_number > 0)
		{
			var _player_name = names[revival[0]];
			var _player_inventory = revival_inventory[0];
			
			var _times_resurrected = ds_list_find_value(oGenerator.times_resurrected, _player_name);
			
			var _respawned_player = SpawnPlayerCharacter(revival[0], _player_name, other.x, other.y - 15 * other.scale, other.row);
			
			_respawned_player.hp = _respawned_player.maxhp - 20 * _times_resurrected;			
			_respawned_player.prev_hp = _respawned_player.hp;	
			
			ds_list_add(oGenerator.times_resurrected, _player_name, _times_resurrected + 1);

			_respawned_player.bullets = 0;
			_respawned_player.state = PlayerStates.NON_CONTROL;
			
			other.resurected_player = _respawned_player;
			
			other.resurected_player.inventory = _player_inventory;
			if (!ds_list_empty(other.resurected_player.inventory))
				other.resurected_player.item_picked_up = true;
			
			for (var i = 0; i < revival_number - 1; ++i)
			{
				revival[i] = revival[i + 1];	
				revival_inventory[i] = revival_inventory[i + 1];	
				
			}
			//pocket[1 + revival_number] = 0;
			revival_number -= 1;
			
			other.image_speed = other.im_speed;
			other.image_index = 1;
			
			
		}
	}
}

if (AnimationEnd())
{
	if (sprite_index == sCloningStation)
	{
		image_index = 0;
		sprite_index = sCloningStationOpen;
	}
	else
	{
		image_index = image_number - 1;
		image_speed = 0;
		with (resurected_player)
		{
			state = PlayerStates.NORMAL;	
			depth = -100 * row - 2;
		}
	}
}



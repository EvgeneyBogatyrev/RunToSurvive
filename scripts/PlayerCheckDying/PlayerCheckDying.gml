///@desc Check if player`s lost
function RecordPlayerDeath(_player, _reason, _damage_amount=undefined) {
	if (!instance_exists(_player))  return;
	if (_reason == undefined || _reason == "")  _reason = "ran out of HP";
	if (_damage_amount == undefined)  _damage_amount = _player.last_damage_amount;

	global.last_death_player = _player.name;
	global.last_death_reason = _reason;
	global.last_death_damage = _damage_amount;
	global.last_death_time = oRoomControl.run_timer;
	global.last_death_score = global.score;
	global.last_death_row = _player.row;
	global.last_death_inventory = _player.inventory;
	global.last_death_gun = _player.pocket[0];
	global.last_death_powerup = _player.pocket[1];
	global.last_death_player_index = _player.player_index;
	global.last_death_sprite = _player.last_damage_sprite;
	global.last_death_image = _player.last_damage_image;

	if (!sprite_exists(global.last_death_sprite))
	{
		global.last_death_sprite = GetSpritesFromName(_player.name).icon;
		global.last_death_image = 0;
	}
}

function PlayerCheckDying() {
	var _multiplayer_run = number_of_players > 1;

	if (state != UniversalStates.DEAD && x < oCamera.left - CAMERA_BOUNDS)
	{
		state = UniversalStates.DEAD;
		last_damage_sprite = GetSpritesFromName(name).out;
		last_damage_image = 0;
		RecordPlayerDeath(id, "was left behind by the camera", 0);
		if (_multiplayer_run)
		{
			with (Create(oCamera.right + 200, oCamera.y - 100, oEssence, row))
			{
					depth -= 2;
					player_ind = other.player_index;
					inventory = other.inventory;
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.pocket[0];
					players_powerup = other.pocket[1];

			}

			for (var j = 0; j < revival_number; ++j)
			{
				with (Create(x + sprite_get_width(sEssence) * (j + 1), y, oEssence, row))
				{
					depth -= 2;
					player_ind = other.revival[j];
					inventory = other.revival_inventory[j];
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.revival_guns[j];
					players_powerup = other.revival_powerups[j];
				}
			}
		}

		if (instance_number(object_index) <= 1)  LevelEnd();

		instance_destroy();
	}

	if (hp <= 0 && state != UniversalStates.DEAD)
	{
		state = UniversalStates.DEAD;
		var _death_reason = last_damage_reason;
		var _death_damage = last_damage_amount;
		if (y > oGenerator.ground[2] + 100)
		{
			_death_reason = "fell below the lowest platform";
			_death_damage = 0;
			last_damage_sprite = GetSpritesFromName(name).out;
			last_damage_image = 0;
		}
		RecordPlayerDeath(id, _death_reason, _death_damage);

		/*
		if (name == "Robo")
		{
			var _counter = 0;
			for (var i = 0; i < 4; ++i)
			{
				var _amount = (i > 1) ? 2 : 1;
				repeat (_amount)
				{
					var _part = Create(x, y - sprite_height * scale, oRoboPart, row);
					with (_part)
					{
						image_index = i;
						depth -= 3;

						if (i == 0)  player_ind = other.player_index;
						else         player_ind = noone;

						var _angle = random_range(0, 180);
						if (i == 0)  _angle = 90;
						xspeed = other.explotion_speed * dcos(_angle);
						yspeed = -other.explotion_speed * dsin(_angle);

						if (_counter == 3 || _counter == 5)  image_xscale = -image_xscale;
					}
					body_parts[_counter++] = _part;
				}
			}
		}
		else
		{*/
		    sprite_index = character.sprites.die;

			image_speed = 0;
			image_index = 0;

			if (_multiplayer_run)
			{
				with (Create(x, y, oEssence, row))
				{
					depth -= 2;
					player_ind = other.player_index;
					inventory = other.inventory;
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.pocket[0];
					players_powerup = other.pocket[1];
				}
			}
		//}

		if (_multiplayer_run)
		{
			for (var j = 0; j < revival_number; ++j)
			{
				with (Create(x + sprite_get_width(sEssence) * (j + 1), y, oEssence, row))
				{
					depth -= 2;
					player_ind = other.revival[j];
					inventory = other.revival_inventory[j];
					times_resurrected = oGenerator.times_resurrected[? names[player_ind]];
					players_gun = other.revival_guns[j];
					players_powerup = other.revival_powerups[j];
				}
			}
		}

		instance_destroy(gun);
		instance_destroy(hands);
		if (instance_number(object_index) <= 1)
		{
			oCamera.follow = id;
			oCamera.focus = CameraFocus.TARGET_ZOOM;
		}
	}


}

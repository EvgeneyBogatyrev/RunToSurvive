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
			
			var _respawned_player = SpawnPlayerCharacter(revival[0], _player_name, other.x, other.y - 15 * other.scale, other.row);
			
			_respawned_player.hp = 50;
			_respawned_player.bullets = 10;
			_respawned_player.state = PlayerStates.NON_CONTROL;
			
			other.resurected_player = _respawned_player;
			
			/* 
			switch (_player_name)
			{
				case "Robo":
					other.resurected_player = Create(other.x, other.y - 15 * other.scale, oPlayer, other.row);
					with(other.resurected_player)
					{
						depth = other.depth + 2;
						sPlayerStand = sCyberStand;
						sPlayerRun = sCyberRun;
						sPlayerJump = sCyberJump;
						sPlayerIdle = sCyberIdle;
						sPlayerDying = sCyberDying;
						sPlayerIcon = sCyberIcon;
						sPlayerOutOfScreen = sCyberOutOfScreen;
						sPlayerHands = sCyberHands;
						_input_type = input_type[other.revival[0]];
						player_index = other.revival[0];
						name = "Robo";
						hp = 50;
						bullets = 10;
						state = PlayerStates.NON_CONTROL;
					}
					break;
				
				case "Kyron":
					other.resurected_player = Create(other.x, other.y - 15 * other.scale, oPlayer, other.row);
					with(other.resurected_player)
					{
						depth = other.depth + 2;
						sPlayerStand = sKyronStand;
						sPlayerRun = sKyronRun;
						sPlayerJump = sKyronJump;
						sPlayerIdle = sKyronIdle;
						sPlayerDying = sKyronDying;
						sPlayerIcon = sKyronIcon;
						sPlayerOutOfScreen = sKyronOutOfScreen;
						sPlayerHands = sKyronHands;
						_input_type = input_type[other.revival[0]];
						player_index = other.revival[0];
						name = "Kyron";
						hp = 50;
						bullets = 10;
						state = PlayerStates.NON_CONTROL;
					}
					break;
				case "LongHair":
					other.resurected_player = Create(other.x, other.y - 15 * other.scale, oPlayer, other.row);
					with(other.resurected_player)
					{
						depth = other.depth + 2;
						sPlayerStand = sLongHairStand;
						sPlayerRun = sLongHairRun;
						sPlayerJump = sLongHairJump;
						sPlayerIdle = sLongHairIdle;
						sPlayerDying = sLongHairDying;
						sPlayerIcon = sLongHairIcon;
						sPlayerOutOfScreen = sLongHairOutOfScreen;
						sPlayerHands = sLongHairHands;
						_input_type = input_type[other.revival[0]];
						name = names[other.revival[0]];
						player_index = other.revival[0];
						hp = 50;
						bullets = 10;
						state = PlayerStates.NON_CONTROL;
					}
					break;
				case "SteamPunk":
					other.resurected_player = Create(other.x, other.y - 15 * other.scale, oPlayer, other.row);
					with(other.resurected_player)
					{
						depth = other.depth + 2;
						sPlayerStand = sSteampunkStand;
						sPlayerRun = sSteampunkRun;
						sPlayerJump = sSteampunkJump;
						sPlayerIdle = sSteampunkIdle;
						sPlayerDying = sSteampunkDying;
						sPlayerIcon = sSteampunkIcon;
						sPlayerOutOfScreen = sSteampunkOutOfScreen;
						sPlayerHands = sSteampunkHands;
						_input_type = input_type[other.revival[0]];
						name = names[other.revival[0]];
						player_index = other.revival[0];
						hp = 50;
						bullets = 10;
						state = PlayerStates.NON_CONTROL;
					}
					break;
					
				
			}
			*/
			
			
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



instance_create_layer(0, 0, "Controllers", oRoomControl);
instance_create_layer(0, 0, "Controllers", oCamera);
instance_create_layer(0, 0, "Controllers", oDrawer);
instance_create_layer(0, 0, "Controllers", oBackgroundControl);
instance_create_layer(0, 0, "Controllers", oBossControl);
instance_create_layer(0, 0, "Controllers", oPause);
instance_create_layer(0, 0, "Controllers", oDifficultyController);

global.level_started = true;

gap = 120;
ground[0] = 444;
ground[1] = ground[0] + 4/5 * gap;
ground[2] = ground[1] + gap;

obstacles = array_create(3, 0);

for (var j = 0; j < 3; ++j) 
{
	var _count = 0;
	for (var i = 0; i * BLOCKSIZE * GetScale(j) < room_width + CAMERA_BOUNDS; ++i) 
	{
		last_block[j] = Create(i * (BLOCKSIZE - 1) * GetScale(j), ground[j], oGroundBlock, j);
		with (last_block[j])
		{
			sprite_index = oRoomControl.room_properties[? "BlockSprite"];
		}
		if (_count % 3 == 0) 
		{
			with (Create(i * (BLOCKSIZE - 1) * GetScale(j), ground[j] + BLOCKSIZE * GetScale(j), oTextureBlock, j))
			{
				sprite_index = oRoomControl.room_properties[? "BlockBigSprite"];	
			}
		}
		_count++;
	}
}


for (var i = 0; i < number_of_players; ++i)
{
	switch (names[i])
	{
		case "Kyron":
			with(Create(500 + ((i == 3)? 100 : 0), ground[i % 3], oPlayer, i % 3))
			{
				depth = -100 * row - 2;
				sPlayerStand = sKyronStand;
				sPlayerRun = sKyronRun;
				sPlayerJump = sKyronJump;
				sPlayerIdle = sKyronIdle;
				sPlayerDying = sKyronDying;
				sPlayerIcon = sKyronIcon;
				sPlayerOutOfScreen = sKyronOutOfScreen;
				sPlayerHands = sKyronHands;
				_input_type = input_type[i];
				name = names[i];
				player_index = i;
			}
			break;
			
		case "Robo":
			with(Create(500 + ((i == 3)? 100 : 0), ground[i % 3], oPlayer, i % 3))
			{
				depth = -100 * row - 2;
				sPlayerStand = sRoboStand;
				sPlayerRun = sRoboRun;
				sPlayerJump = sRoboJump;
				sPlayerIdle = sRoboIdle;
				sPlayerDying = sKyronDying;
				sPlayerIcon = sRoboIcon;
				sPlayerOutOfScreen = sRoboOutOfScreen;
				sPlayerHands = sRoboHands;
				_input_type = input_type[i];
				name = names[i];
				player_index = i;
			}
			break;
			
		case "LongHair":
			with(Create(500 + ((i == 3)? 100 : 0), ground[i % 3], oPlayer, i % 3))
			{
				depth = -100 * row - 2;
				sPlayerStand = sLongHairStand;
				sPlayerRun = sLongHairRun;
				sPlayerJump = sLongHairJump;
				sPlayerIdle = sLongHairIdle;
				sPlayerDying = sLongHairDying;
				sPlayerIcon = sLongHairIcon;
				sPlayerOutOfScreen = sLongHairOutOfScreen;
				sPlayerHands = sLongHairHands;
				_input_type = input_type[i];
				name = names[i];
				player_index = i;
			}
			break;
		case "SteamPunk":
			with(Create(500 + ((i == 3)? 100 : 0), ground[i % 3], oPlayer, i % 3))
			{
				depth = -100 * row - 2;
				sPlayerStand = sSteampunkStand;
				sPlayerRun = sSteampunkRun;
				sPlayerJump = sSteampunkJump;
				sPlayerIdle = sSteampunkIdle;
				sPlayerDying = sSteampunkDying;
				sPlayerIcon = sSteampunkIcon;
				sPlayerOutOfScreen = sSteampunkOutOfScreen;
				sPlayerHands = sSteampunkHands;
				_input_type = input_type[i];
				name = names[i];
				player_index = i;
			}
			break;
	}
}
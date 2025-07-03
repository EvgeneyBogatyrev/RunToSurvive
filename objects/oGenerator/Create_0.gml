if (global.DEBUG)
{
	//number_of_players += 3;	
}

instance_create_layer(0, 0, "Controllers", oDifficultyController);
instance_create_layer(0, 0, "Controllers", oRoomControl);
instance_create_layer(0, 0, "Controllers", oCamera);
instance_create_layer(0, 0, "Controllers", oDrawer);
instance_create_layer(0, 0, "Controllers", oBackgroundControl);
instance_create_layer(0, 0, "Controllers", oQuests);
instance_create_layer(0, 0, "Controllers", oBossControlQuest);
instance_create_layer(0, 0, "Controllers", oPause);
instance_create_layer(0, 0, "Controllers", oDebugConsole);

// Particles
global.particle_systems = [];
for (var _i = 0; _i < 3; ++_i)
{
	var _p = part_system_create_layer("Instances", true);
	part_system_depth(_p, -100 * _i);
	global.particle_systems[_i] = _p;
}

// Bullets


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

times_resurrected = ds_map_create();

if (global.DEBUG)
{
	//number_of_players -= 3;
}

for (var i = 0; i < number_of_players; ++i)
{
	SpawnPlayerCharacter(i, names[i], 500 + ((i == 3)? 100 : 0), ground[i % 3], i % 3);
	ds_map_add(times_resurrected, names[i], 0);
}

if (global.DEBUG)
{
	//number_of_players += 3;
	//input_type[1] = InputTypes.KEYBOARD;
	//input_type[2] = InputTypes.KEYBOARD;
	//SpawnPlayerCharacter(1, "Steampunk", 500 + ((1 == 3)? 100 : 0), ground[1 % 3], 1 % 3);
	//SpawnPlayerCharacter(1, "Cyber", 500 + ((1 == 3)? 100 : 0), ground[1 % 3], 1 % 3);
	//SpawnPlayerCharacter(1, "Kyron", 500 + ((1 == 3)? 100 : 0), ground[1 % 3], 1 % 3);
}


preprocess_forbidden_obstacles = false;
if (global.DEBUG)
{
	var _debug_players = floor(BoundBetween(global.debug_keyboard_players, 1, 3));
	if (number_of_players < _debug_players)  number_of_players = _debug_players;

	if (number_of_players > 1 && input_type[0] == InputTypes.ANY)
	{
		input_type[0] = InputTypes.KEYBOARD;
	}

	var _debug_names = ["Kyron", "Steampunk", "Cyber"];
	var _debug_inputs = [InputTypes.KEYBOARD, InputTypes.DEBUG_KEYBOARD_WASD, InputTypes.DEBUG_KEYBOARD_IJKL];
	for (var _debug_i = 0; _debug_i < min(number_of_players, array_length(_debug_inputs)); _debug_i++)
	{
		if (array_length(names) <= _debug_i || names[_debug_i] == undefined || names[_debug_i] == "")
		{
			names[_debug_i] = _debug_names[_debug_i];
		}
		input_type[_debug_i] = _debug_inputs[_debug_i];
	}
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

gap = 132;
ground[0] = 600;
ground[1] = ground[0] + 4/5 * gap;
ground[2] = ground[1] + gap;

oBackgroundControl.layers = NewBackround(GetCurrrentBgSprites(), true)


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

for (var i = 0; i < number_of_players; ++i)
{
	SpawnPlayerCharacter(i, names[i], 500 + ((i == 3)? 100 : 0), ground[i % 3] - 1, i % 3);
	ds_map_add(times_resurrected, names[i], 0);
}


preprocess_forbidden_obstacles = false;

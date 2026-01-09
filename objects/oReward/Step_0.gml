if (!created_reward)
{
	var _prev_index = [];
	created_reward = true;
	for (var i = 0; i < stand_count; i++) {
		item_stands[i] = Create(
			x + (i - index_shift) * stand_spacing,
			y,
			oRewardStand,
			0
		);
    
		with (item_stands[i]) {
			var _all_items = GetAllDropItems();
			while (true)
			{
				item_index = _all_items[irandom_range(0, len(_all_items) - 1)];
				if (!array_contains(_prev_index, item_index))
				{
					break;	
				}
			}
			if (i == 1)
			{
				var _create_hammer = false;
				with (oPlayer)
				{
					if (name == "Steampunk")
					{
						_create_hammer = true;	
					}
				}
				
				if (_create_hammer)
				{
					item_index = HAMMER_TIME_INUMBER;	
				}
			}
			if (i == other.stand_count - 1)
			{
				item_index =choose(HEARTH_INUMBER, BATTERY_INUMBER);	
			}
			array_push(_prev_index, item_index);
			setup_item();
		}
	}
	
	
	var _need_to_create_revival = false;
	with (oPlayer)
	{
		if (revival_number > 0)
		{
			_need_to_create_revival = true;	
		}
	}
	
	if (_need_to_create_revival)
	{
		Create(oCamera.right - 200 + x - oCamera.x, oGenerator.ground[2], oCloningStation, 2);	
	}
	
}

if (x < oCamera.x)
{
	StopRoom();
	stopped_room = true;
	oCamera.follow = id;
}

if (x < oCamera.left - CAMERA_OFFSET || all_done())
{
	ResumeRoom();
	oBossControlQuest.timer = 3 * 60;
	oRoomControl.gamestate = GameState.NORMAL;
	oCamera.follow = oPlayer;
	instance_destroy(id);
}

event_inherited();
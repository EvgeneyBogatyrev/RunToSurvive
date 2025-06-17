if (!created_reward)
{
	var _prev_index = [];
	created_reward = true;
	for (var i = 0; i < stand_count; i++) {
		item_stands[i] = Create(
			x + (i - 1.5) * stand_spacing,
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
			if (i == 2)
			{
				item_index = BATTERY_INUMBER;	
			}
			if (i == 3)
			{
				item_index = HEARTH_INUMBER;	
			}
			array_push(_prev_index, item_index);
			setup_item();
		}
	}
}

if (x < oCamera.x)
{
	StopRoom();
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
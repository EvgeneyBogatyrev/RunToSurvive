// Calibarate over the ground
if (!ground_calibrated)
{
	while (CheckCollisions(x, y, oSolidParent, row))
	{
		y -= 1;	
	}
	//ground_calibrated = true;	
}


if (shown_hp != hp)  healthbar_alpha = 1;
shown_hp = ApproachTo(shown_hp, hp);

if (!active && state != HalfBossStates.INACTIVE)
{
	saved_state = state;
	state = HalfBossStates.INACTIVE;
}

if (hp <= 0 && state != UniversalStates.DEAD && state != HalfBossStates.INACTIVE)
{
	StopBattle();
	state = UniversalStates.DEAD;
	image_index = 0;
	if (!not_give_score)
	{
		global.score += 25;
		if (notice_player == ReturnNoone)
		{
			global.score += 10;	
		}
	}
	oDifficultyController.minibosses_defeated += 1;
	
	//with (Create(x, y, oItemDrop, row))
	//{
	//	depth -= 2;
	//	image = HEARTH_INUMBER;
	//}
	
	var _image;
	var _rnd_val = random_range(0, 100);
	
	
	if (object_index == oStump)
	{
		if (_rnd_val < 50)
		{
			_image = HEARTH_INUMBER;	
		}
		else
		{
			_image = BATTERY_INUMBER;	
		}
		if (oRoomControl.gamestate != GameState.BOSS)
		{
			oQuests.stumps_killed += 1;
		}
	}
	else if (object_index == oArcher)
	{
		if (_rnd_val < 85)
		{
			_image = BATTERY_INUMBER;	
		}
		else
		{
			var _all_items = GetAllDropItems();
			_image = _all_items[irandom_range(0, len(_all_items) - 1)];
		}
		if (oRoomControl.gamestate != GameState.BOSS)
		{
			oQuests.archers_killed += 1;
		}
	}
	else if (object_index == oBilly)
	{
		if (_rnd_val < 85)
		{
			_image = HEARTH_INUMBER;	
		}
		else
		{
			var _all_items = GetAllDropItems();
			_image = _all_items[irandom_range(0, len(_all_items) - 1)];
		}
		if (oRoomControl.gamestate != GameState.BOSS)
		{
			oQuests.billys_killed += 1;
		}
	}
	
	with (Create(x, y, oItemDrop, row))
	{
		depth -= 2;
		image = _image;
	}
}

if (x < oCamera.left - CAMERA_OFFSET)  instance_destroy();	


switch(state)
{
	case HalfBossStates.IDLE:
		player = script_execute(notice_player);
		if (knockbacked)  state = HalfBossStates.KNOCKBACKED;
		if (player != noone)  state =  HalfBossStates.TRIGGERED;
		break;

	case HalfBossStates.TRIGGERED:
		if (knockbacked)  state = HalfBossStates.KNOCKBACKED;

		if (!instance_exists(player) || player.state == UniversalStates.DEAD)
		{
			player = noone;
			state = HalfBossStates.IDLE;
		} 
		else
		{
			player = script_execute(notice_player);
			if (player == noone)  state =  HalfBossStates.IDLE;	
		}
		break;
		
	case HalfBossStates.INACTIVE:
		if (active)  state = saved_state;
		break;
		
	case HalfBossStates.KNOCKBACKED:
		if (!knockbacked)
		{
			state = HalfBossStates.IDLE;
		}
		else
		{
			if (x < oCamera.left) || (x > oCamera.right)
			{
				xspeed = 0
				state = HalfBossStates.IDLE
			}
		}
		break;
	case UniversalStates.DEAD:
		if (AnimationEnd())  image_speed = 0;
		if (!CheckCollisions(x, y + 1, oSolidParent, row) && instance_exists(oWallOfFleshController))
		{
			real_image_alpha -= 0.05;
			if (real_image_alpha <= 0)
			{
				instance_destroy();	
			}
			image_alpha = real_image_alpha;
		}
		else
		{
			real_image_alpha = image_alpha;	
		}
		break;
		
	default:
		break;
}


if (CheckCollisions(x, y - 1, oSolidParent, row))
{	
	if (bbox_left > oCamera.right)  
	{
		instance_destroy();
		exit;
	}
	var _obstacle = instance_place(x, y - 1, oSolidParent);
	Assert(_obstacle != noone, "Invalid obstacle!");
		
	if (!escape_direction)  escape_direction = sign(x - _obstacle.x);     // if escape_direction isn`t set yet, 
	xspeed = abs(walkspeed) * escape_direction / 2;	                          // calculate the direction player need to go out of the obstacle
}
else  
{
	escape_direction = 0;	
}

//Gravity
if (!CheckCollisions(x, y + 1, oSolidParent, row) && can_be_knockbacked)
{
	//yspeed -= grav;
	
	if (CheckCollisions(x, y + yspeed * scale, oSolidParent, row))
	{
		repeat (abs(yspeed))
		{
			if (CheckCollisions(x, y + sign(yspeed), oSolidParent, row))
			{
				break;	
			}
			y += sign(yspeed);
		}
		yspeed = 0;
	}
}




event_inherited();

if (!CheckCollisions(x, y + 1, oSolidParent, row))
{
	yspeed -= grav;

}
else
{
	yspeed = 0;
	knockbacked = false
}



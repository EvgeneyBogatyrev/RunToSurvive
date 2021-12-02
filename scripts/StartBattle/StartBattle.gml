///@desc Deactivates objects on other rows and starts battle
///@args row
///@args player
///@args opponent
function StartBattle(argument0, argument1, argument2) {

	if (oRoomControl.gamestate != GameState.NORMAL)  exit;

	var _row      = argument0;
	var _player   = argument1;
	var _opponent = argument2;

	with(oPlayer) if (id == _player)  
	{
		if (row != _row)  exit;
	}

	var _deactivate_array = [oObstacle, oChargeStation, oStructureBlock, oMinorItem, oChest]; // objects to deactivate
	var _array_len = array_length_1d(_deactivate_array);

	var _instance;
	for (var i = 0; i < _array_len; ++i) 
	{
		_instance = _deactivate_array[i];
		with (_instance)
		{
			if (row > _row)  active = false;
		}
	}

	with (oGroundBlock)
	{
		if (CheckCollisions(x, y - BLOCKSIZE * scale, oStructureBlock, row))
		{
			saved_sprite = sprite_index;
			if (row > _row)  sprite_index = oRoomControl.room_properties[? "BlockSprite"];
		}
	}

	StopRoom();
	with (oRoomControl)
	{
		gamestate = GameState.BATTLE;
		battle_row = _row;
		opponent = _opponent;
	}

	var _follow;
	with (_opponent)
	{
		var _left_bound = x;
		var _right_bound = x;
	
		while (_left_bound > oCamera.left && !CheckCollisions(_left_bound, y - 1, oObstacle, row) && !CheckCollisions(_left_bound, y - 1, oBlock, row))
			_left_bound--;
		
		while (_right_bound < oCamera.right && !CheckCollisions(_right_bound, y - 1, oObstacle, row) && !CheckCollisions(_right_bound, y - 1, oBlock, row))
			_right_bound++;
		
		var _center = (_right_bound + _left_bound) / 2;

		_follow = Create(_center, y, oFollow, row);
	
		with(Create(x, y - sprite_height * scale, oAlertSign, row))  host = other.id;	
	}

	with (oCamera)
	{
		if (_row == 0)       focus = CameraFocus.ROW0;
		else if (_row == 1)  focus = CameraFocus.ROW1;
		else if (_row == 2)  focus = CameraFocus.ROW2;
	
		mode = CameraMode.STATIC;
	
		follow = _follow;	
	}




}

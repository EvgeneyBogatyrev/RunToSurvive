///@desc StopBattle()
///@args row
///@args player
function StopBattle() {

	///Deactivates objects on other rows and starts battle

	if (oRoomControl.gamestate != GameState.BATTLE)  exit;

	if (id != oRoomControl.opponent)  exit;

	with (all)  active = true;
	
	with (oPlayer)  blocked = false;

	with (oGroundBlock)	
	{
	
		var _collider = Create(x, y - BLOCKSIZE * scale, oTest, row);
	
		with (_collider)
		{
			if (CheckCollisions(x, y, oStructureBlock, row))	
			{
				other.sprite_index = oRoomControl.room_properties[? "BlockEmptySprite"];	
			}
		}
	
		instance_destroy(_collider);
	}

	ResumeRoom();
	with(oRoomControl)
	{
		gamestate = GameState.NORMAL;
		opponent = noone;
	}


	oCamera.focus = CameraFocus.ROW2;
	oCamera.mode = CameraMode.MOVING;
	instance_destroy(oCamera.follow);
	oCamera.follow = oPlayer;




}

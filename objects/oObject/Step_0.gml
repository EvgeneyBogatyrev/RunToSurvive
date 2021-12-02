Scale();

if (!active)  
{
	var _alpha = 0;
	if (oRoomControl.gamestate == GameState.BATTLE)
	{
		with (oPlayer)
		{
			if (row != oRoomControl.battle_row)  _alpha = INACTIVE_ALPHA;
		}	
	}
	image_alpha = max(_alpha, image_alpha - 0.1);	
}
else  image_alpha = min(1, image_alpha + 0.1);	



if (keyboard_check_pressed(ord("B")))
	oPlayer.bullets += 2000;
if (keyboard_check_pressed(ord("H")))
	oPlayer.hp += 2000;
if (keyboard_check_pressed(ord("R")))
	room_restart();

	
if (roomspeed != 0 && abs(roomspeed) < 5)  roomspeed -= acc;
	
	
if (gamestate == GameState.BATTLE)
{
	with (oPlayer)
	{
		if (row == other.battle_row)
		{
			blocked = true;
		}
	}
}	



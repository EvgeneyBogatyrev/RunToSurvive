if (global.DEBUG)
{
	if (keyboard_check_pressed(ord("B")))
		oPlayer.bullets += 2000;
	if (keyboard_check_pressed(ord("H")))
		oPlayer.hp += 2000;
	if (keyboard_check_pressed(vk_f8))
	{
		global.debug_keyboard_players = floor(BoundBetween(global.debug_keyboard_players - 1, 1, 3));
		room_restart();
	}
	if (keyboard_check_pressed(vk_f9))
	{
		global.debug_keyboard_players = floor(BoundBetween(global.debug_keyboard_players + 1, 1, 3));
		room_restart();
	}
}
if (keyboard_check_pressed(ord("R")))
	room_restart();

	
if (roomspeed != 0 && abs(roomspeed) < roomspeed_limit)  roomspeed -= acc;
if (roomspeed < -roomspeed_limit)						 roomspeed = -roomspeed_limit;
	
	
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

if (gamestate == GameState.NORMAL)
{
	if (score_timer <= 0)
	{
		score_timer = room_speed;
		global.score += 1;
	}
	else
	{
		score_timer -= 1;	
	}
}

run_timer += delta_time;


//if (oPlayer.x > 10000)
//{
//	with (all)
//	{
//		x -= 10000;	
//	}
//}

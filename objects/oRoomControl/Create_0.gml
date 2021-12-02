enum GameState 
{
	NORMAL,
	BATTLE,
	BOSS
};

roomspeed = -2;
acc = 0.000125;
gamestate = GameState.NORMAL;

battle_row = -1;
opponent = noone;

saved_speed = 0;

room_properties = ds_map_create();
GetStandartRoomProperties();
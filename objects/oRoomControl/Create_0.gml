enum GameState 
{
	NORMAL,
	BATTLE,
	BOSS,
	LOOT	//Retreiving loot
};

roomspeed = -2;
acc = 0.000125;
roomspeed_limit = 6;
gamestate = GameState.NORMAL;

battle_row = -1;
opponent = noone;

saved_speed = 0;
global.score = 0;

score_timer_max = 60;
score_timer = room_speed;
block_score = false;


room_properties = ds_map_create();
GetStandartRoomProperties();
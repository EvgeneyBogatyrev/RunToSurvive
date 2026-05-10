enum GameState 
{
	NORMAL,
	BATTLE,
	BOSS,
	LOOT	//Retreiving loot
};

roomspeed = -2;
acc = 0.00005;
roomspeed_limit = GetStats("Max roomspeed");
gamestate = GameState.NORMAL;

battle_row = -1;
opponent = noone;

saved_speed = 0;
global.score = 0;

score_timer_max = 60;
score_timer = room_speed;
block_score = false;

run_timer = 0;

global.last_death_player = "";
global.last_death_reason = "was defeated";
global.last_death_damage = 0;
global.last_death_time = 0;
global.last_death_score = 0;
global.last_death_row = 0;
global.last_death_inventory = undefined;
global.last_death_gun = 0;
global.last_death_powerup = 0;
global.last_death_player_index = -1;
global.last_death_sprite = noone;
global.last_death_image = 0;

room_properties = ds_map_create();
GetStandartRoomProperties();

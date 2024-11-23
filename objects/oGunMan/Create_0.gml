/// @description
event_inherited();

enum GunManStates
{
	FIGHT,
	RECHARGE,
	FLEE,
	VICTORY
};

enum GunManHpState
{
	FIRST,
	SECOND,
	THIRD
};

state = UniversalStates.INTRO;

first_hp = 10 + 2 * oDifficultyController.bosses_defeated  * GetStats("Increase hp");
second_hp = 10 + 2 * oDifficultyController.bosses_defeated  * GetStats("Increase hp");
third_hp = 10 + 2 * oDifficultyController.bosses_defeated  * GetStats("Increase hp");

if (global.DEBUG)
{
	first_hp = 1;
	second_hp = 1;	
	third_hp = 1;

}

cum_hp = first_hp + second_hp + third_hp;
cum_hp_max = cum_hp;

maxhp = cum_hp;
hp = maxhp;

hp_limit = second_hp + third_hp;

loot_profile_id = GUNMAN_LOOT_INUMBER;

//Intro
intro_timer_max = 6 * 60;
intro_timer = intro_timer_max;
follow_object = undefined;
area_created = false;
area_updated = false;

_charge_tower_shape = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 1, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0],		
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0],		
	[0, 0, 0, 0, 0, 2, 1, 1, 1, 4, 4, 4, 4, 4, 1, 1, 1, 3, 0, 0, 0, 0, 0],		
	[0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0],
	[2, 1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 1, 1, 1, 3],
];

_middle = [				
	[2, 1, 3],
];

charging_station = undefined;
charge_reload_timer = 0;
charge_reload_timer_max = 5 * 60;

walkspeed = 6;
jumpspeed = 12;
changing_row = false;
row_der = 0;
jump_counter = 0;
grounded_counter = 0;
grounded = false;

move = -1;
desired_x_position = 0;
desired_row = 1;


go_for_a_charge = false;

bullets = 20;
damageBoost = 19;
gun = Create(x, y, oGun, 0);
gun.host = id;

gun.current_gun = Gun.STANDART_GUN
pocket = [STDGUN_INUMBER];

drill_damage = 1;

state_change_timer = -1;
state_change_timer_max = 1.5 * 60;
next_state = GunManStates.FIGHT;

charging_station = Create(x - 400, y - 165, oChargeStation, 0);

hp_state = GunManHpState.FIRST;


// Select a player
select_new_player = function() {
	var _player_list = [];
	for (var i = 0; i < instance_number(oPlayer); ++i)
	{
		var _player = instance_find(oPlayer, i);
		if (_player.state != UniversalStates.DEAD)
		{
			_player_list[array_length(_player_list)] = _player;
		}
	}
	if (array_length(_player_list) == 0)
	{
		return undefined;	
	}
	return _player_list[random_range(0, array_length(_player_list))];
}

opponent = select_new_player();	

character = new Character("Robo");
idlecounter = 60;

hands = Create(x, y, oHands, 0);	
with(hands)	 host = other.id;

explotion_speed = 6;


		


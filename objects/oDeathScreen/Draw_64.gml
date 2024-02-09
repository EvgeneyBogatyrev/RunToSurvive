draw_set_alpha(0.75);
draw_set_color(c_black);

var _w = window_get_width();
var _h = window_get_height();

draw_rectangle(16, 16, _w - 16, _h - 16, false);

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);

draw_text(_w / 2, 64, "YOU" + (global.multiplayer ? " ALL " : " ") + "DIED");

//Score result
draw_set_halign(fa_left);
var _difficulties = ["EASY", "NORMAL", "HARD", "EXTREME"];
draw_text(128, 128, "Difficulty: " + _difficulties[global.difficulty]);
var _add = "";
if (is_highscore)
{
	_add = " - HIGHSCORE!";
}
draw_text(128, 168, "Score: " + string(global.score) + _add);

//Time calculation
var _full_time_in_seconds = floor(time_of_the_run / 1000000);

var _sec = _full_time_in_seconds % 60;
var _time_in_min = floor(_full_time_in_seconds / 60);
var _min = _time_in_min % 60;
var _hrs = floor(_time_in_min / 60);

var _hrs_str = string(_hrs);
_hrs_str = string_length(_hrs_str) > 1 ? _hrs_str : "0" + _hrs_str;

//Time result
var _s = _hrs_str + ":" + string_replace_all(string_format(_min, 2, 0) + ":" + string_format(_sec, 2, 0), " ", "0");   
draw_text(128, 208, "Time: " + _s);


//Player and inventory printout

draw_text(128, 296, "Your posessions:")

var _essence_number = instance_number(oEssence);
var _draw_y = 296 + 64;

for (var _i = 0; _i < _essence_number; _i++)
{
	var _ess = instance_find(oEssence, _i);
	var _player_name = names[_ess.player_ind];
	var _inventory = _ess.inventory;
	var _gun = _ess.players_gun;	
	var _powerup = _ess.players_powerup;
	
	_draw_y += 96 * _i;

	var _player_icon = GetSpritesFromName(_player_name).icon;
	
	draw_sprite(_player_icon, 0, 128, _draw_y - 30);
	
	var _items = ds_map_create();
	
	for (var _j = 0; _j < ds_list_size(_inventory); _j++)
	{
		var _id = _inventory[|_j].icon_index;
		if (!ds_map_exists(_items, _id)) ds_map_add(_items, _id, 1);
		else ds_map_replace(_items, _id, _items[? _id] + 1);
	}
	
	var _keys_arr = ds_map_keys_to_array(_items);
	
	for (var _k = 0; _k < ds_map_size(_items); _k++)
	{
		var _id = _keys_arr[_k];
		var _amount = _items[? _id];
		
		var _draw_x = 128 + 32 + 64 * (_k + 1);
		
		draw_sprite_ext(sPassiveItems, _id, _draw_x, _draw_y, 0.5, 0.5, 0, c_white, 1);
		draw_text(_draw_x + 25, _draw_y + 25, string(_amount));
	}
	
	var _draw_x = 128 + 32 + 64 * (ds_map_size(_items) + 1);
	// Draw gun and powerups
	if (_essence_number <= 2)
	{
		_draw_y += 64;	
		_draw_x = 128;
		
		if (_powerup == 0)
		{
			_draw_x += 32;	
		}
	}
	
	
	draw_sprite_ext(sItems, _gun, _draw_x, _draw_y, 0.5, 0.5, 0, c_white, 1);
	
	if (_powerup > 0)
	{
		draw_sprite_ext(sItems, _powerup, _draw_x + 64, _draw_y, 0.5, 0.5, 0, c_white, 1);
	}
	
	ds_map_destroy(_items);
	
}



draw_set_alpha(1);
draw_set_alpha(0.92);
draw_set_color(c_black);

var _w = display_get_gui_width();
var _h = display_get_gui_height();

draw_rectangle(16, 16, _w - 16, _h - 16, false);

draw_set_alpha(1);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);

var _accent = c_yellow;
var _danger = make_color_rgb(255, 96, 96);
var _success = make_color_rgb(92, 255, 132);
var _muted = make_color_rgb(180, 190, 205);

var _multiplayer_run = number_of_players > 1;
draw_text(_w / 2, 92, _multiplayer_run ? "YOU ALL DIED" : "YOU DIED");

draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _label_x = 128;
var _value_x = 296;
var _killer_x = min(max(560, _w - 224), _w - 128);
var _death_text_width = max(160, _killer_x - _value_x - 156);

var _difficulties = ["EASY", "NORMAL", "HARD", "EXTREME"];
draw_set_color(c_white);
draw_text(_label_x, 152, "Difficulty:");
draw_set_color(_accent);
draw_text(_value_x, 152, _difficulties[global.difficulty]);

var _score_text = string(global.score);
draw_set_color(c_white);
draw_text(_label_x, 192, "Score:");
draw_set_color(_accent);
draw_text(_value_x, 192, _score_text);
if (is_highscore)
{
	draw_set_color(_success);
	draw_text(_value_x + string_width(_score_text) + 24, 192, "HIGHSCORE!");
}

var _time_text = SecondsToString(time_of_the_run / 1000000);
draw_set_color(c_white);
draw_text(_label_x, 232, "Time:");
draw_set_color(_accent);
draw_text(_value_x, 232, _time_text);

var _death_player = global.last_death_player;
if (_death_player == "")  _death_player = "The last player";

var _death_reason = global.last_death_reason;
var _death_damage = global.last_death_damage;
var _death_y = 280;
var _death_text = _death_player + " " + _death_reason;
draw_set_color(c_white);
draw_text(_label_x, _death_y, "Last death:");
draw_set_color(_danger);
draw_text_ext(_value_x, _death_y, _death_text, 24, _death_text_width);

var _damage_y = _death_y + max(40, string_height_ext(_death_text, 24, _death_text_width) + 10);
draw_set_color(c_white);
draw_text(_label_x, _damage_y, "Damage:");
draw_set_color(_death_damage > 0 ? _danger : _muted);
draw_text(_value_x, _damage_y, string(_death_damage));

var _bosses = instance_exists(oDifficultyController) ? oDifficultyController.bosses_defeated : 0;
var _minibosses = instance_exists(oDifficultyController) ? oDifficultyController.minibosses_defeated : 0;
var _minions = instance_exists(oDifficultyController) ? oDifficultyController.minions_defeated : 0;
var _defeated_y = _damage_y + 40;
draw_set_color(c_white);
draw_text(_label_x, _defeated_y, "Defeated:");

var _defeat_x = _value_x;
var _bosses_text = string(_bosses);
draw_set_color(_accent);
draw_text(_defeat_x, _defeated_y, _bosses_text);
_defeat_x += string_width(_bosses_text);
draw_set_color(c_white);
draw_text(_defeat_x, _defeated_y, " bosses, ");
_defeat_x += string_width(" bosses, ");

var _minibosses_text = string(_minibosses);
draw_set_color(_accent);
draw_text(_defeat_x, _defeated_y, _minibosses_text);
_defeat_x += string_width(_minibosses_text);
draw_set_color(c_white);
draw_text(_defeat_x, _defeated_y, " minibosses, ");
_defeat_x += string_width(" minibosses, ");

var _minions_text = string(_minions);
draw_set_color(_accent);
draw_text(_defeat_x, _defeated_y, _minions_text);
_defeat_x += string_width(_minions_text);
draw_set_color(c_white);
draw_text(_defeat_x, _defeated_y, " minions");

var _final_speed = instance_exists(oRoomControl) ? abs(oRoomControl.saved_speed) : 0;
var _players_text = string(number_of_players);
var _speed_text = string_format(_final_speed, 1, 2);
var _players_y = _defeated_y + 40;
draw_set_color(c_white);
draw_text(_label_x, _players_y, "Players:");
draw_set_color(_accent);
draw_text(_value_x, _players_y, _players_text);

var _speed_label_x = _value_x + string_width(_players_text) + 64;
draw_set_color(c_white);
draw_text(_speed_label_x, _players_y, "Final speed:");
draw_set_color(_accent);
draw_text(_speed_label_x + string_width("Final speed:") + 16, _players_y, _speed_text);

var _killer_sprite = global.last_death_sprite;
if (sprite_exists(_killer_sprite))
{
	var _killer_y = 348;
	var _killer_image = global.last_death_image;
	var _killer_caption = string_replace(_death_reason, "was defeated by ", "");
	var _killer_bbox_left = sprite_get_bbox_left(_killer_sprite);
	var _killer_bbox_right = sprite_get_bbox_right(_killer_sprite);
	var _killer_bbox_top = sprite_get_bbox_top(_killer_sprite);
	var _killer_bbox_bottom = sprite_get_bbox_bottom(_killer_sprite);
	var _killer_bbox_w = max(1, _killer_bbox_right - _killer_bbox_left);
	var _killer_bbox_h = max(1, _killer_bbox_bottom - _killer_bbox_top);
	var _killer_bbox_center_x = (_killer_bbox_left + _killer_bbox_right) / 2;
	var _killer_bbox_center_y = (_killer_bbox_top + _killer_bbox_bottom) / 2;
	var _killer_scale = min(2.5, min(160 / _killer_bbox_w, 152 / _killer_bbox_h));
	var _killer_draw_x = _killer_x + (sprite_get_xoffset(_killer_sprite) - _killer_bbox_center_x) * _killer_scale;
	var _killer_draw_y = _killer_y + (sprite_get_yoffset(_killer_sprite) - _killer_bbox_center_y) * _killer_scale;

	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(_killer_x, 152, "Cause of death");
	draw_set_color(_danger);
	draw_text_ext(_killer_x, 196, _killer_caption, 24, 260);
	draw_sprite_ext(_killer_sprite, _killer_image, _killer_draw_x, _killer_draw_y, _killer_scale, _killer_scale, 0, c_white, 1);
	draw_set_halign(fa_left);
}

var _essence_number = instance_number(oEssence);
var _loadout_title_y = min(_players_y + 56, _h - 208);
var _loadout_area_x = _label_x;
var _loadout_area_right = _w - 128;
var _loadout_area_w = _loadout_area_right - _loadout_area_x;
var _loadout_top = _loadout_title_y + 52;

//Player and inventory printout
if (_essence_number > 0)
{
	draw_set_color(c_white);
	draw_text(_label_x, _loadout_title_y, "Your possessions:");

	var _slot_count = min(_essence_number, 4);
	var _columns = _slot_count == 1 ? 1 : 2;
	var _rows = ceil(_slot_count / _columns);
	var _slot_gap_x = 48;
	var _slot_gap_y = 8;
	var _slot_w = (_loadout_area_w - _slot_gap_x * (_columns - 1)) / _columns;
	var _slot_h = min(82, (_h - _loadout_top - 32 - _slot_gap_y * (_rows - 1)) / _rows);
	var _compact = _slot_count > 1;
	var _player_icon_scale = _compact ? 0.72 : 0.9;
	var _item_scale = _compact ? 0.38 : 0.5;
	var _item_spacing = _compact ? 42 : 58;
	var _equipment_spacing = _compact ? 38 : 54;

	for (var _i = 0; _i < _slot_count; _i++)
	{
		var _ess = instance_find(oEssence, _i);
		var _player_name = names[_ess.player_ind];
		var _inventory = _ess.inventory;
		var _gun = _ess.players_gun;
		var _powerup = _ess.players_powerup;

		var _slot_col = _i mod _columns;
		var _slot_row = _i div _columns;
		var _slot_x = _loadout_area_x + _slot_col * (_slot_w + _slot_gap_x);
		var _slot_y = _loadout_top + _slot_row * (_slot_h + _slot_gap_y);
		if (_slot_count == 3 && _slot_row == 1)
		{
			_slot_x += (_slot_w + _slot_gap_x) / 2;
		}

		var _content_y = _slot_y + max(8, (_slot_h - 44) / 2);
		var _player_icon = GetSpritesFromName(_player_name).icon;

		draw_sprite_ext(_player_icon, 0, _slot_x, _content_y - 8, _player_icon_scale, _player_icon_scale, 0, c_white, 1);

		var _items = ds_map_create();

		for (var _j = 0; _j < ds_list_size(_inventory); _j++)
		{
			var _id = _inventory[|_j].icon_index;
			if (!ds_map_exists(_items, _id)) ds_map_add(_items, _id, 1);
			else ds_map_replace(_items, _id, _items[? _id] + 1);
		}

		var _keys_arr = ds_map_keys_to_array(_items);
		var _item_start_x = _slot_x + 76;
		var _equipment_x = _slot_x + _slot_w - (_powerup > 0 ? _equipment_spacing * 2 : _equipment_spacing);
		var _max_items = max(0, floor((_equipment_x - _item_start_x - 16) / _item_spacing));
		var _visible_items = min(ds_map_size(_items), _max_items);

		for (var _k = 0; _k < _visible_items; _k++)
		{
			var _id = _keys_arr[_k];
			var _amount = _items[? _id];
			var _item_x = _item_start_x + _item_spacing * _k;

			draw_sprite_ext(sPassiveItems, _id, _item_x, _content_y + 6, _item_scale, _item_scale, 0, c_white, 1);
			draw_set_color(_accent);
			draw_text(_item_x + 18, _content_y + 24, string(_amount));
		}

		if (ds_map_size(_items) > _visible_items)
		{
			draw_set_color(_accent);
			draw_text(_item_start_x + _item_spacing * _visible_items, _content_y + 18, "+" + string(ds_map_size(_items) - _visible_items));
		}

		draw_sprite_ext(sItems, _gun, _equipment_x, _content_y + 8, _item_scale, _item_scale, 0, c_white, 1);

		if (_powerup > 0)
		{
			draw_sprite_ext(sItems, _powerup, _equipment_x + _equipment_spacing, _content_y + 8, _item_scale, _item_scale, 0, c_white, 1);
		}

		ds_map_destroy(_items);
	}
}

if (_essence_number == 0 && global.last_death_inventory != undefined && ds_exists(global.last_death_inventory, ds_type_list))
{
	draw_set_color(c_white);
	draw_text(_label_x, _loadout_title_y, "Final loadout:");

	var _final_player_icon = GetSpritesFromName(global.last_death_player).icon;
	draw_sprite_ext(_final_player_icon, 0, _loadout_area_x, _loadout_top, 0.9, 0.9, 0, c_white, 1);

	var _final_items = ds_map_create();
	var _final_inventory = global.last_death_inventory;
	for (var _final_j = 0; _final_j < ds_list_size(_final_inventory); _final_j++)
	{
		var _final_inv_id = _final_inventory[|_final_j].icon_index;
		if (!ds_map_exists(_final_items, _final_inv_id)) ds_map_add(_final_items, _final_inv_id, 1);
		else ds_map_replace(_final_items, _final_inv_id, _final_items[? _final_inv_id] + 1);
	}

	var _final_keys_arr = ds_map_keys_to_array(_final_items);
	for (var _final_k = 0; _final_k < ds_map_size(_final_items); _final_k++)
	{
		var _final_item_id = _final_keys_arr[_final_k];
		var _final_amount = _final_items[? _final_item_id];
		var _final_draw_x = _loadout_area_x + 32 + 64 * (_final_k + 1);

		draw_sprite_ext(sPassiveItems, _final_item_id, _final_draw_x, _loadout_top + 24, 0.5, 0.5, 0, c_white, 1);
		draw_set_color(_accent);
		draw_text(_final_draw_x + 25, _loadout_top + 49, string(_final_amount));
	}

	var _final_weapon_x = _loadout_area_x + 32 + 64 * (ds_map_size(_final_items) + 1);
	draw_sprite_ext(sItems, global.last_death_gun, _final_weapon_x, _loadout_top + 24, 0.5, 0.5, 0, c_white, 1);

	if (global.last_death_powerup > 0)
	{
		draw_sprite_ext(sItems, global.last_death_powerup, _final_weapon_x + 64, _loadout_top + 24, 0.5, 0.5, 0, c_white, 1);
	}

	ds_map_destroy(_final_items);
}

draw_set_color(c_white);
draw_set_alpha(1);

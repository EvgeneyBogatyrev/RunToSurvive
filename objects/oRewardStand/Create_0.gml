event_inherited();

// obj_shop_stand - Create Event
item_index = 0; // Default, overridden by kiosk
item_name = "";
item_price = 0;
item_sprite = -1;
item_desc = "";

function setup_item()
{
	for (var _i = 0; _i < array_length(item_description); ++_i)
	{
		if (item_description[_i].item_id == item_index)
		{
			item_desc = item_description[_i].description;
			item_name = item_description[_i].item_name;
			break;
		}
	}
}

function string_wrap(text, max_width) {
    var words = string_split(text, " ");
    var lines = [];
    var current_line = "";
    
    for (var i = 0; i < array_length(words); i++) {
        var test_line = current_line + (current_line == "" ? "" : " ") + words[i];
        if (string_width(test_line) <= max_width) {
            current_line = test_line;
        } else {
            array_push(lines, current_line);
            current_line = words[i];
        }
    }
    if (current_line != "") array_push(lines, current_line);
    return lines;
}

font_shop_small = fntItemDescription;

reward_pickup_half_width = 140;
reward_pickup_top = 90;
reward_pickup_bottom = 28;

function player_in_pickup_zone(_player_id)
{
	if (!instance_exists(_player_id))
	{
		return false;	
	}
	if (_player_id.row != row || _player_id.state == UniversalStates.DEAD)
	{
		return false;	
	}
	
	var _left = x - reward_pickup_half_width * scale;
	var _right = x + reward_pickup_half_width * scale;
	var _top = y - reward_pickup_top * scale;
	var _bottom = y + reward_pickup_bottom * scale;
	
	return _player_id.bbox_right >= _left
		&& _player_id.bbox_left <= _right
		&& _player_id.bbox_bottom >= _top
		&& _player_id.bbox_top <= _bottom;
}

function any_player_in_pickup_zone()
{
	if (!instance_exists(oReward))
	{
		return false;	
	}
	
	for (var _player_count = 0; _player_count < instance_number(oPlayer); ++_player_count)
	{
		var _player_id = instance_find(oPlayer, _player_count);
		if (player_in_pickup_zone(_player_id) && oReward.can_player_get_reward(_player_id))
		{
			return true;	
		}
	}
	
	return false;
}


allowed_to_move = true;
allowed_to_move_hor = true;
allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i < 5; ++i)
{
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}

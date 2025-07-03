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


allowed_to_move = true;
allowed_to_move_hor = true;
allowed_array = [];
allowed_hor_array = [];

for (var i = 0; i < 5; ++i)
{
	allowed_array[i] = true;
	allowed_hor_array[i] = true;
}
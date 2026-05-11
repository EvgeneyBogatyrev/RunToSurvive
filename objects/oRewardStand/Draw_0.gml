// obj_shop_stand - Draw Event
var _player_near = any_player_in_pickup_zone();
var _zone_half_width = reward_pickup_half_width * scale;
var _marker_y = y - 4 * scale;
var _marker_height = 24 * scale;
var _marker_tip = 34 * scale;
var _marker_width = 4;

if (_player_near)
{
	draw_set_alpha(0.65);
	draw_set_color(c_yellow);
	draw_line_width(x - _zone_half_width, _marker_y, x - _zone_half_width + _marker_tip, _marker_y, _marker_width);
	draw_line_width(x - _zone_half_width, _marker_y, x - _zone_half_width, _marker_y - _marker_height, _marker_width);
	draw_line_width(x + _zone_half_width - _marker_tip, _marker_y, x + _zone_half_width, _marker_y, _marker_width);
	draw_line_width(x + _zone_half_width, _marker_y, x + _zone_half_width, _marker_y - _marker_height, _marker_width);
}
draw_set_alpha(1);
draw_set_color(c_white);

// Draw stand base (if you have a sprite)
draw_self();

// --- Light circle behind item ---

draw_set_color(c_white);
draw_set_alpha(0.3);
draw_circle(x, y - 160, 112, false); // Adjust radius as needed
draw_set_alpha(1);


// --- Pulsing item sprite ---

draw_sprite_ext(
    sItems, 
    item_index, 
    x, 
    y - 160, 
    2, 2, 
    0, 
    c_white, 
    0.7 + 0.3 * abs(sin(current_time * 0.0025)) // Smoother pulse
);

/*
// obj_shop_stand - Draw Event

// ... (previous draw code for stand, item sprite, etc.) ...

// --- Text Description with Multi-Line Wrapping ---
var desc = item_desc;
var max_line_width = 220; // Wrap text if wider than this
var line_height = 20; // Vertical space between lines
var start_y = y - 160; // Higher position (was y - 120)

// Split description into lines
var lines = string_wrap(desc, max_line_width); // Custom function (see below)

// Draw transparent background for description (scales to line count)
draw_set_color(c_black);
draw_set_alpha(0.5);
var bg_width = max_line_width + 16; // Padding
var bg_height = (array_length(lines) * line_height) + 8;
draw_rectangle(
    x - bg_width/2, 
    start_y - 4, 
    x + bg_width/2, 
    start_y + bg_height - 12, 
    false
);
draw_set_alpha(1);

// Draw each line
draw_set_font(font_shop_small);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
for (var i = 0; i < array_length(lines); i++) {
    draw_text(x, start_y + (i * line_height), lines[i]);
}
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

*/

draw_set_font(fntItemDescription);
draw_set_alpha(0.58);
draw_set_color(c_black);
var _x_offset = 10;
var _y_offset = 12;

var _text_scale = 1.55;
var _text_width = 285;
var _text_sep = 20;
var _text_height = string_height_ext(item_desc, _text_sep, _text_width);
draw_set_font(fntMenu);
var _title_height = string_height(item_name);
draw_set_font(fntItemDescription);

var _y_point = y - 320;
var _title_y = _y_point - (_text_height * _text_scale) / 2 - 34;
var _box_half_width = (_text_width * _text_scale) / 2 + _x_offset;
var _box_half_height = (_text_height * _text_scale) / 2 + _y_offset;

draw_rectangle(x - _box_half_width, _title_y - _title_height - 8, x + _box_half_width, _y_point + _box_half_height, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_set_font(fntMenu);
draw_text(x, _title_y, item_name);

draw_set_font(fntItemDescription);
draw_text_ext_transformed(x, _y_point, item_desc, _text_sep, _text_width, _text_scale, _text_scale, 0);

// ... (rest of your draw code) ...
// --- Highlight if player is nearby ---
if (_player_near) {
    draw_set_color(c_yellow);
    draw_set_alpha(0.22);
    draw_circle(x, y - 160, 112, false); // Glow effect
    draw_set_alpha(1);
    draw_set_color(c_white);
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

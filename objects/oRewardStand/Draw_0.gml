// obj_shop_stand - Draw Event
// Draw stand base (if you have a sprite)
draw_self();

// --- Light circle behind item ---

draw_set_color(c_white);
draw_set_alpha(0.3);
draw_circle(x, y - 80, 56, false); // Adjust radius as needed
draw_set_alpha(1);


// --- Pulsing item sprite ---

draw_sprite_ext(
    sItems, 
    item_index, 
    x, 
    y - 80, 
    1, 1, 
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
draw_set_alpha(0.5);
draw_set_color(c_black);
var _x_offset = 10;
var _y_offset = 10;

var _text_width = 200;
var _text_height = string_height_ext(item_desc, 16, _text_width);

var _y_point = y - 160


draw_rectangle(x - (_text_width / 2 + _x_offset), _y_point - _text_height / 2 - _y_offset, x + _text_width / 2 + _x_offset, _y_point + _text_height / 2 + _y_offset, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

draw_text_ext_transformed(x, _y_point, item_desc, 16, _text_width, 1, 1, 0);

// ... (rest of your draw code) ...
// --- Highlight if player is nearby ---
if (place_meeting(x, y, oPlayer)) {
    draw_set_color(c_yellow);
    draw_set_alpha(0.2);
    draw_circle(x, y - 80, 56, false); // Glow effect
    draw_set_alpha(1);
    draw_set_color(c_white);
}
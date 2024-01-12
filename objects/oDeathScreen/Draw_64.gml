draw_set_alpha(0.75);
draw_set_color(c_black);

var _w = window_get_width();
var _h = window_get_height();

draw_rectangle(16, 16, _w - 16, _h - 16, false);

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);

draw_text(_w / 2, 64, "YOU" + (global.multiplayer ? " ALL " : " ") + "DIED");

draw_set_halign(fa_left);
draw_text(128, 128, "Score: " + string(global.score));

var _full_time_in_seconds = floor(time_of_the_run / 1000000);

var _sec = _full_time_in_seconds % 60;
var _time_in_min = floor(_full_time_in_seconds / 60);
var _min = _time_in_min % 60;
var _hrs = floor(_time_in_min / 60);

var _hrs_str = string(_hrs);
_hrs_str = string_length(_hrs_str) > 1 ? _hrs_str : "0" + _hrs_str;


var _s = _hrs_str + ":" + string_replace_all(string_format(_min, 2, 0) + ":" + string_format(_sec, 2, 0), " ", "0");   


draw_text(128, 256, "Time: " + _s);


draw_set_alpha(1);